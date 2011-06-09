# -*- coding: utf-8 -*-

# 役判定（役満）を行うクラスメソッド群
module Mjt
  module Analysis
    class YakuJudger

      # 国士無双
      def self.kokushi?(tehai, agari); return false; end

      # 四暗刻
      def self.suuankou?(tehai, agari); return false; end
      
      # TODO 間違ってます
      # 大三元
      def self.daisangen?(tehai, agari)
        has_haku = false
        has_chun = false
        has_hatsu = false
      
        tehai.mentsu_list.each do |mentsu|
          if mentsu.mentsu_type == 'k'
            if mentsu.pai_list[0].type == 'j' && mentsu.pai_list[0].number == 5
              has_haku = true
            elsif mentsu.pai_list[0].type == 'j' && mentsu.pai_list[0].number == 6
              has_chun = true
            elsif mentsu.pai_list[0].type == 'j' && mentsu.pai_list[0].number == 7
              has_hatsu = true
            end
          end
        
          if has_haku && has_chun && has_hatsu
            return true
          end
          return false
        end
      end
  
    end
  end
end

