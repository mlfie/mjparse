module Mjt
 module Analysis
  # 最も高い手を判定する
  class TeyakuDecider
    def self.get_agari_teyaku(agari)
      resolver = Mjt::Analysis::MentsuResolver.new
    
      resolver.get_mentsu(agari)
      
      if resolver.tehai_list.size == 0
        return false
      end
    
      resolver.tehai_list.each do | tehai |
        # 役を取得する
        Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
        # 得点を計算する
        Mjt::Analysis::ScoreCalculator.calculate_point(tehai, agari)
      end
      
      # 最も点数が高くなるものを採用する
      max_point = 0
      index = -1
      resolver.tehai_list.each_with_index { |tehai, idx| 
        if max_point < tehai.total_point
          max_point = tehai.total_point
          index = idx
        end
      }
      if index < 0
        return false
      end
      
      tehai = resolver.tehai_list[index]
      
      # アガリに値をセット
      agari.total_fu_num  = tehai.fu_num
      agari.total_han_num = tehai.han_num
      agari.mangan_scale  = tehai.mangan_scale
      agari.total_point   = tehai.total_point
      agari.parent_point  = tehai.parent_point
      agari.child_point   = tehai.child_point
      agari.yaku_list     = tehai.yaku_list
      
      return true
    end
  end
 end
end
