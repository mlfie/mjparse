module Mjt
 module Analysis
  # 最も高い手を判定する
  class TeyakuDecider
    def self.get_agari_teyaku(agari)
      resolver = Mjt::Analysis::MentsuResolver.new
    
      resolver.get_mentsu(agari)
      
      if resolver.result_list.size == 0
        return false
      end
    
      resolver.result_list.each do | result |
        # 役を取得する
        Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
        # 得点を計算する
        Mjt::Analysis::ScoreCalculator.calculate_point(result, agari)
      end
      
      # 最も点数が高くなるものを採用する
      max_point = 0
      index = -1
      resolver.result_list.each_with_index { |result, idx| 
        if max_point < result.total_point
          max_point = result.total_point
          index = idx
        end
      }
      if index < 0
        return false
      end
      
      result = resolver.result_list[index]
      
      # アガリに値をセット
      agari.total_fu_num  = result.fu_num
      agari.total_han_num = result.han_num
      agari.mangan_scale  = result.mangan_scale
      agari.total_point   = result.total_point
      agari.parent_point  = result.parent_point
      agari.child_point   = result.child_point
      agari.yaku_list     = result.yaku_list
      
      return true
    end
  end
 end
end
