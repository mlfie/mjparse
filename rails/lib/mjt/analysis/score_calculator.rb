module Mjt::Analysis
  # 得点を計算する
  class ScoreCalculator
    
    # 得点を計算して結果を返す
    def self.calculate_point(tehai, agari)
      tehai.fu_num = self.ceil_one_level(self.calc_fu(tehai, agari))
      tehai.han_num = self.calc_han(tehai)
      tehai.mangan_scale = self.calc_mangan_scale(tehai)
      base_point = self.calc_base_point(tehai)
      tehai.child_point = self.ceil_ten_level(self.calc_child_point(base_point, tehai, agari))
      tehai.parent_point = self.ceil_ten_level(self.calc_parent_point(base_point, tehai, agari))
      tehai.total_point = self.ceil_ten_level(self.calc_total_point(base_point, tehai, agari))
    end
    
    # 符を計算する
    private
    def self.calc_fu(tehai, agari)
      # 副底
      total_fu = 20
      
      ### 雀頭による符
      if tehai.atama.type == Pai::PAI_TYPE_JIHAI
        # 風牌の場合
        if Pai::PAI_NUMBER_TON <= tehai.atama.number && tehai.atama.number <= Pai::PAI_NUMBER_PEI
          # 自風の計算
          if tehai.atama.number == Pai::PAI_NUMBER_TON && agari.jikaze == 'ton'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_NAN && agari.jikaze == 'nan'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_SHA && agari.jikaze == 'sha'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_PEI && agari.jikaze == 'pei'
            total_fu += 2
          end
          # 場風の計算
          if tehai.atama.number == Pai::PAI_NUMBER_TON && agari.bakaze == 'ton'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_NAN && agari.bakaze == 'nan'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_SHA && agari.bakaze == 'sha'
            total_fu += 2
          elsif tehai.atama.number == Pai::PAI_NUMBER_PEI && agari.bakaze == 'pei'
            total_fu += 2
          end
        # 三元牌の場合
        elsif Pai::PAI_NUMBER_HAKU <= tehai.atama.number && tehai.atama.number <= Pai::PAI_NUMBER_CHUN
          total_fu += 2
        end
      end
      
      ### 刻子による符
      tehai.mentsu_list.each do |mentsu|
        if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU
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
      tehai.mentsu_list.each do |mentsu|
        # 嵌張待ちの場合
        if mentsu.kanchan?
          total_fu += 2
          break
        end
        # 辺張待ちの場合
        if mentsu.penchan?
          total_fu += 2
          break
        end
      end
      # 単騎待ちの場合
      if tehai.atama.agari
        total_fu += 2
      end

      ### 自摸和了による符
      if agari.is_tsumo
        pinfu = false
        tehai.yaku_list.each do |yaku|
          if yaku.name == 'pinfu'
            pinfu = true
            break
          end
        end
        if ! pinfu
          total_fu += 2
        end
      end
      
      ### 門前でのロンアガリによる符
      # TODO 門前 + !is_tsumo
      
      return total_fu
    end
    
    # 飜を計算する
    def self.calc_han(tehai)
      total_han = 0
      tehai.yaku_list.each do |yaku|
        total_han += yaku.han_num
      end
      return total_han
    end
    
    # 満貫の倍数を計算する
    def self.calc_mangan_scale(tehai)
      if tehai.han_num <= 4
        return 0
      elsif (tehai.han_num = 3 && tehai.fu_num >= 70) || (tehai.han_num = 4 && tehai.fu_num >= 40) || tehai.han_num <= 5
        return 1
      elsif tehai.han_num <= 7
        return 1.5
      elsif tehai.han_num <= 10
        return 2
      elsif tehai.han_num <= 12
        return 3
      else
        return 4
      end
    end
    
    # 基本点を計算する
    def self.calc_base_point(tehai)
      base_point = tehai.fu_num * ( 2 ** (tehai.han_num + 2) )
      if base_point > 2000
        base_point = 2000
      end
      return base_point
    end
    
    # 子が支払う点数を計算する
    def self.calc_child_point(base_point, tehai, agari)
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
      if tehai.mangan_scale > 0
        return point * tehai.mangan_scale
      end
      return point
    end
    
    # 親が支払う点数を計算する
    def self.calc_parent_point(base_point, tehai, agari)
      point = 0
      # 子の場合のみ計算する
      if ! agari.is_parent
        if agari.is_tsumo
          point = base_point * 2
        else
          point = base_point * 4
        end
      end
      if tehai.mangan_scale > 0
        return point * tehai.mangan_scale
      end
      return point
    end
    
    # 総合得点を計算する
    def self.calc_total_point(base_point, tehai, agari)
      point = 0
      if agari.is_parent
        if agari.is_tsumo
          point = tehai.child_point * 3
        else
          point = tehai.child_point
        end
      else
        if agari.is_tsumo
          point = tehai.child_point * 2 + tehai.parent_point
        else
          point = tehai.parent_point
        end
      end
      return point
    end
    
    def self.ceil_one_level(point)
      return ( ( point + 9 ) / 10 ) * 10
    end
    
    def self.ceil_ten_level(point)
      return ( ( point + 90 ) / 100 ) * 100
    end
  end
end