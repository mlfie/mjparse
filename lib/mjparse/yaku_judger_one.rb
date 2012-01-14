# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')
require File.join(File.dirname(__FILE__), 'kyoku')

### 役判定（1飜）を行うクラスメソッド群
module Mjparse
  module YakuJudgerOne

  ### リーチ
    def reach?(tehai, kyoku)
      kyoku.reach?
    end

    ### 平和
    def pinfu?(tehai, kyoku)
      #鳴きなし判定
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          if pai.naki
            return false
           end
        end
      end
      #コーツなし判定
      tehai.mentsu_list.each do |mentsu|
        if mentsu.pai_list[0].number == mentsu.pai_list[1].number || mentsu.pai_list[1].number == mentsu.pai_list[2].number
          return false
        end
      end
    
      #対子が風・三元牌でナシ判定
      kazemap = [[Kyoku::KYOKU_KAZE_TON, 1], 
                [Kyoku::KYOKU_KAZE_NAN, 2], 
                [Kyoku::KYOKU_KAZE_SHA, 3], 
                [Kyoku::KYOKU_KAZE_PEI, 4]]
      kazemap.each do | ibakaze |
        if kyoku.bakaze == ibakaze[0] && tehai.atama.number == ibakaze[1] && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          return false
        end
      end
      
      kazemap.each do | ijikaze |
        if kyoku.jikaze == ijikaze[0] && tehai.atama.number == ijikaze[1] && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          return false
        end
      end
      if tehai.atama.type == Pai::PAI_TYPE_JIHAI && (tehai.atama.number == Pai::PAI_NUMBER_HAKU || tehai.atama.number == Pai::PAI_NUMBER_HATSU || tehai.atama.number == Pai::PAI_NUMBER_CHUN)
        return false
      end

      # 両面で待っていることを判定
      if tehai.atama.agari == true
        return false
      end
    
      tehai.mentsu_list.each do |mentsu|
        if mentsu.pai_list[1].agari == true
          return false
        end
        if mentsu.pai_list[0].agari == true && mentsu.pai_list[2].number == 9
          return false
        end
        if mentsu.pai_list[2].agari == true && mentsu.pai_list[0].number == 1
          return false
        end
      end
      return true
    end

    ### 断么九
    def tanyao?(tehai, kyoku)
      if tehai.atama.yaochu?
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do | pai |
          if pai.yaochu?
            return false
          end
        end
      end
      return true
    end

    ### 一盃口
    def iipeikou?(tehai, kyoku) 
      #鳴きなし判定
      tehai.mentsu_list.each do |mentsu|
        mentsu.pai_list.each do |pai|
          if pai.naki
            return false
           end
        end
      end
      
      tehai.mentsu_list.each_with_index do |mentsu_1,i|
        tehai.mentsu_list.each_with_index do |mentsu_2,j|
          if i != j
            count = 0
            [0,1,2].each do |k|
              if mentsu_1.pai_list[k] == mentsu_2.pai_list[k] && mentsu_1.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu_2.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU
                count += 1
              end
            end
            if count == 3 
              return true
            end
          end # end if
        end # end each
      end # end each
      return false
    end # end def

    ### 一発
    def ippatsu?(tehai, kyoku)
      if kyoku.is_ippatsu
        return true
      end
      return false
    end
      
    ### 門前清自摸和
    def tsumo?(tehai, kyoku)
      if kyoku.is_tsumo
        return true
      end
      return false
    end

    ### 自風(東)
    def jikazeton?(tehai, kyoku)
      if kyoku.jikaze != Kyoku::KYOKU_KAZE_TON
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_TON
            return true
          end
        end
      end
      return false
    end

    ### 自風(南)
    def jikazenan?(tehai, kyoku)
      if kyoku.jikaze != Kyoku::KYOKU_KAZE_NAN
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_NAN
            return true
          end
        end
      end
      return false
    end

    ### 自風(西)
    def jikazesha?(tehai, kyoku)
      if kyoku.jikaze != Kyoku::KYOKU_KAZE_SHA
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_SHA
            return true
          end
        end
      end
      return false
    end

    ### 自風(北)
    def jikazepei?(tehai, kyoku)
      if kyoku.jikaze != Kyoku::KYOKU_KAZE_PEI
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_PEI
            return true
          end
        end
      end
      return false
    end

    ### 場風(東)
    def bakazeton?(tehai, kyoku)
      if kyoku.bakaze != Kyoku::KYOKU_KAZE_TON
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_TON
            return true
          end
        end
      end
      return false
    end

    ### 場風(南)
    def bakazenan?(tehai, kyoku)
      if kyoku.bakaze != Kyoku::KYOKU_KAZE_NAN
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_NAN
            return true
          end
        end
      end
      return false
    end

    ### 場風(西)
    def bakazesha?(tehai, kyoku)
      if kyoku.bakaze != Kyoku::KYOKU_KAZE_SHA
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_SHA
            return true
          end
        end
      end
      return false
    end

    ### 場風(北)
    def bakazepei?(tehai, kyoku)
      if kyoku.bakaze != Kyoku::KYOKU_KAZE_PEI
        return false
      end
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_PEI
            return true
          end
        end
      end
      return false
    end

    ### 白
    def haku?(tehai, kyoku)
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_HAKU
            return true
          end
        end
      end
      return false
    end
    
    ### 發
    def hatsu?(tehai, kyoku)
      tehai.mentsu_list.each do |mentsu|        
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_HATSU
            return true
          end
        end
      end
      return false
    end

    ### 中
    def chun?(tehai, kyoku)
      tehai.mentsu_list.each do |mentsu|
        if mentsu.koutsu? || mentsu.kantsu?
          if mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI && mentsu.pai_list[0].number == Pai::PAI_NUMBER_CHUN
            return true
          end
        end
      end
      return false
    end

    ### 海底摸月
    def haitei?(tehai, kyoku)
      if kyoku.is_haitei
        if kyoku.is_tsumo
          return true
        end
      end
      return false
    end

    ### 河底撈魚
    def houtei?(tehai, kyoku)
      if kyoku.is_haitei
        if !kyoku.is_tsumo
          return true
        end
      end
      return false
    end

    ### 嶺上開花
    def rinshan?(tehai, kyoku)
      if kyoku.is_rinshan
        if kyoku.is_tsumo
          return true
        end
      end
      return false
    end

    ### 槍槓
    def chankan?(tehai, kyoku)
      if kyoku.is_chankan
        if !kyoku.is_tsumo
          return true
        end
      end
      return false
    end
  end
end
