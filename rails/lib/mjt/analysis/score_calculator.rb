module Mjt::Analysis
  # 得点を計算する
  class ScoreCalculator
    
    # 得点を計算して結果を返す
    def self.calculate_point(result, agari)
      result.fu_num = self.calc_fu(result, agari)
      result.han_num = self.calc_han(result)
      result.mangan_scale = self.calc_mangan_scale(result)
      base_point = self.calc_base_point(result)
      result.child_point = cail_ten_level(self.calc_child_point(base_point, result, agari))
      result.parent_point = cail_ten_level(self.calc_parent_point(base_point, result, agari))
      result.total_point = cail_ten_level(self.calc_total_point(base_point, result, agari))
    end
    
    # 符を計算する
    private
    def self.calc_fu(result, agari)
      # 副底
      total_fu = 20
      
      ### 雀頭による符
      if result.atama.type == 'j'
        # 風牌の場合
        if 1 <= result.atama.number && result.atama.number <= 4
          # 自風の計算
          if result.atama.number == 0 && agari.jikaze == 'ton'
            total_fu += 2
          elsif result.atama.number == 1 && agari.jikaze == 'nan'
            total_fu += 2
          elsif result.atama.number == 2 && agari.jikaze == 'sha'
            total_fu += 2
          elsif result.atama.number == 3 && agari.jikaze == 'pei'
            total_fu += 2
          end
          # 場風の計算
          if result.atama.number == 0 && agari.bakaze == 'ton'
            total_fu += 2
          elsif result.atama.number == 1 && agari.bakaze == 'nan'
            total_fu += 2
          elsif result.atama.number == 2 && agari.bakaze == 'sha'
            total_fu += 2
          elsif result.atama.number == 3 && agari.bakaze == 'pei'
            total_fu += 2
          end
        # 三元牌の場合
        elsif 5 <= result.atama.number && result.atama.number <= 7
          total_fu += 2
        end
      end
      
      ### 刻子による符
      result.mentsu_list.each do |mentsu|
        if mentsu.mentsu_type == 'k' 
          # 字牌の場合
          if mentsu.pai_list[0].yaochu?
            total_fu += 8
          else
            # 中張牌の場合
            total_fu += 4
          end
        end
      end
      
      ### 待ちの形による符
      result.mentsu_list.each do |mentsu|
        # 嵌張待ちの場合
        if mentsu.pai_list[1].agari
          total_fu += 2
          break
        end
        # 辺張待ちの場合
        if ( mentsu.pai_list[0].number == 1 && mentsu.pai_list[2].agari ) || ( mentsu.pai_list[2].number == 9 && mentsu.pai_list[0].agari )
          total_fu += 2
          break
        end
      end
      # 単騎待ちの場合
      if result.atama.agari
        total_fu += 2
      end

      ### 自摸和了による符
      if agari.is_tsumo
        # TODO 平和を含まない場合
        if true
          total_fu += 2
        end
      end
      
      return self.ceil_one_level(total_fu)
    end
    
    # 飜を計算する
    def self.calc_han(result)
      total_han = 0
      result.yaku_list.each do |yaku|
        total_han += yaku.han_num
      end
      return total_han
    end
    
    # 満貫の倍数を計算する
    def self.calc_mangan_scale(result)
      if result.han_num <= 4
        return 0
      elsif result.han_num <= 5
        return 1
      elsif result.han_num <= 7
        return 1.5
      elsif result.han_num <= 10
        return 2
      elsif result.han_num <= 12
        return 3
      else
        return 4
      end
    end
    
    # 基本点を計算する
    def self.calc_base_point(result)
      base_point = result.fu_num * 2 ** (result.han_num + 2)
      if base_point > 2000
        base_point = 2000
      end
      return base_point
    end
    
    # 子が支払う点数を計算する
    def self.calc_child_point(base_point, result, agari)
      point = 0
      if agari.is_parent
        if agari.is_tsumo
          point = base_point * 2
        else
          point = base_point * 6
        end
      else
        if agari.is_tsumo
          point = base_point
        else
          point = base_point * 4
        end
      end
      if result.han_num >= 5
        return point * result.mangan_scale
      end
      return point
    end
    
    # 親が支払う点数を計算する
    def self.calc_parent_point(base_point, result, agari)
      point = 0
      if ! agari.is_parent
        if agari.is_tsumo
          point = base_point * 2
        else
          point = base_point * 4
        end
      end
      if result.han_num >= 5
        return point * result.mangan_scale
      end
      return point
    end
    
    # 総合得点を計算する
    def self.calc_total_point(base_point, result, agari)
      if agari.is_parent
        if agari.is_tsumo
          return result.child_point * 3
        end
        return base_point * 6
      else
        if agari.is_tsumo
          return result.child_point * 2 + result.parent_point
        end
        return base_point * 4
      end
    end
    
    def self.ceil_one_level(point)
      return ( ( point + 9 ) / 10 ) * 10
    end
    
    def self.cail_ten_level(point)
      return ( ( point + 90 ) / 100 ) * 100
    end
  end
end