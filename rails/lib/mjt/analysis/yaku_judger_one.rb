# -*- coding: utf-8 -*-

### 役判定（1飜）を行うクラスメソッド群
module Mjt
  module Analysis
    class YakuJudger
	
	  ### リーチ
      def self.reach?(tehai, agari)
	     if agari.reach_num == 1
		   return true
		 end
		 return false
	  end
	
      ### 平和
      def self.pinfu?(tehai, agari)
        #コーツなし判定
        tehai.mentsu_list.each do |mentsu|
          if mentsu.pai_list[0].number == mentsu.pai_list[1].number || mentsu.pai_list[1].number == mentsu.pai_list[2].number
            return false
          end
        end
      
        #対子が風・三元牌でナシ判定
        kazemap = [["ton", 1], ["nan", 2], ["sya", 3], ["pei", 4]]
        kazemap.each do | ibakaze |
          if agari.bakaze == ibakaze[0] && tehai.atama.number == ibakaze[1] 
            return false
          end
        end
        
        kazemap.each do | ijikaze |
          if agari.jikaze == ijikaze[0] && tehai.atama.number == ijikaze[1] 
            return false
          end
        end
        
        if tehai.atama.type == "j" && (tehai.atama.number == "5" || tehai.atama.number == "6" || tehai.atama.number == "7")
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
      def self.tanyao?(tehai, agari)
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
      def self.iipeikou?(tehai, agari) 
        tehai.mentsu_list.each_with_index do |mentsu_1,i|
          tehai.mentsu_list.each_with_index do |mentsu_2,j|
            if i != j
              count=0
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

      ### 立直
      def self.reach?(tehai, agari)
        if agari.reach_num == "1"
          return true
        end
        return false
      end

      ### 一発
      def self.ippatsu?(tehai, agari)
        if agari.is_ippatsu
          return true
        end
        return false
      end
        
      ### 門前清自摸和
      def self.tsumo?(tehai, agari)
        if agari.is_tsumo
          return true
        end
        return false
      end

      ### 東
      def self.ton?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 1
          end 
          return true if count == 3
        end
        return false
      end

      ### 南
      def self.nan?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 2
          end 
          return true if count == 3
        end
        return false
      end

      ### 西
      def self.sha?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 3
          end 
          return true if count == 3
        end
        return false
      end

      ### 北
      def self.pei?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 4
          end 
          return true if count == 3
        end
        return false
      end

      ### 白
      def self.haku?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 5
          end 
          return true if count == 3
        end
        return false
      end
      
      ### 發
      def self.hatsu?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 6
          end 
          return true if count == 3
        end
        return false
      end

      ### 中
      def self.chun?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          count = 0 
          mentsu.pai_list.each do |pai| 
            count += 1 if pai.type == "j" && pai.number == 7
          end 
          return true if count == 3
        end
        return false
      end

      ### 海底摸月
      def self.haitei?(tehai, agari)
        if agari.is_haitei
          if agari.is_tsumo
            return true
          end
        end
        return false
      end

      ### 河底撈魚
      def self.houtei?(tehai, agari)
        if agari.is_haitei
          if !agari.is_tsumo
            return true
          end
        end
        return false
      end

      ### 嶺上開花
      def self.rinshan?(tehai, agari)
        if agari.is_rinshan
          return true
        end
        return false
      end

      ### 槍槓
      def self.chankan?(tehai, agari)
        if agari.is_chankan
          return true
        end
        return false
      end

    end
  end
end
