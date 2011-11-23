# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/kyoku'

### 役判定（1飜）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger
	
	  ### リーチ
      def reach?(tehai, agari)
	     if agari.reach_num == 1
		   return true
		 end
		 return false
	  end
	
      ### 平和
      def pinfu?(tehai, agari)
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
          if agari.bakaze == ibakaze[0] && tehai.atama.number == ibakaze[1] && tehai.atama.type == Pai::PAI_TYPE_JIHAI
            return false
          end
        end
        
        kazemap.each do | ijikaze |
          if agari.jikaze == ijikaze[0] && tehai.atama.number == ijikaze[1] && tehai.atama.type == Pai::PAI_TYPE_JIHAI
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
      def tanyao?(tehai, agari)
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
      def iipeikou?(tehai, agari) 
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
                if mentsu_1.pai_list[k] == mentsu_2.pai_list[k]
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
      def ippatsu?(tehai, agari)
        if agari.is_ippatsu
          return true
        end
        return false
      end
        
      ### 門前清自摸和
      def tsumo?(tehai, agari)
        if agari.is_tsumo
          return true
        end
        return false
      end

      ### 東
      def ton?(tehai, agari)
        if agari.bakaze != Kyoku::KYOKU_KAZE_TON and agari.jikaze != Kyoku::KYOKU_KAZE_TON
          return false
        end
        
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_TON
          end 
          return true if count == 3
        end
        return false
      end

      ### 南
      def nan?(tehai, agari)
        if agari.bakaze != Kyoku::KYOKU_KAZE_NAN and agari.jikaze != Kyoku::KYOKU_KAZE_NAN
          return false
        end
        
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_NAN
          end 
          return true if count == 3
        end
        return false
      end

      ### 西
      def sha?(tehai, agari)
        if agari.bakaze != Kyoku::KYOKU_KAZE_SHA and agari.jikaze != Kyoku::KYOKU_KAZE_SHA
          return false
        end
        
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_SHA
          end 
          return true if count == 3
        end
        return false
      end

      ### 北
      def pei?(tehai, agari)
        if agari.bakaze != Kyoku::KYOKU_KAZE_PEI and agari.jikaze != Kyoku::KYOKU_KAZE_PEI
          return false
        end
        
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_PEI
          end 
          return true if count == 3
        end
        return false
      end

      ### 白
      def haku?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_HAKU
          end 
          return true if count == 3
        end
        return false
      end
      
      ### 發
      def hatsu?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|        
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_HATSU
          end 
          return true if count == 3
        end
        return false
      end

      ### 中
      def chun?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == Pai::PAI_TYPE_JIHAI && pai.number == Pai::PAI_NUMBER_CHUN
          end 
          return true if count == 3
        end
        return false
      end

      ### 海底摸月
      def haitei?(tehai, agari)
        if agari.is_haitei
          if agari.is_tsumo
            return true
          end
        end
        return false
      end

      ### 河底撈魚
      def houtei?(tehai, agari)
        if agari.is_haitei
          if !agari.is_tsumo
            return true
          end
        end
        return false
      end

      ### 嶺上開花
      def rinshan?(tehai, agari)
        if agari.is_rinshan
          if agari.is_tsumo
            return true
          end
        end
        return false
      end

      ### 槍槓
      def chankan?(tehai, agari)
        if agari.is_chankan
          if !agari.is_tsumo
            return true
          end
        end
        return false
      end

    end
  end
end
