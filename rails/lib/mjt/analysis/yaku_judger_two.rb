# -*- coding: utf-8 -*-

# 役判定（2飜）を行うクラスメソッド群
module Mjt
  module Analysis
    class YakuJudger
      ### ダブル立直
      def self.doublereach?(tehai, agari); return false; end

      ### 七対子
      def self.chitoitsu?(tehai, agari); return false; end

      ### 混全帯么九
      def self.chanta?(tehai, agari); return false; end

      ### 一気通貫
      def self.ikkitsukan?(tehai, agari); return false; end

      ### 三色同順
      def self.sanshoku?(tehai, agari)
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "s"
            tehai.mentsu_list.each do | mentsu2|
              if mentsu2.mentsu_type == "s" && mentsu.pai_list[0].type != mentsu2.pai_list[0].type
                if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
                  tehai.mentsu_list.each do | mentsu3|
                    if mentsu3.mentsu_type == "s" && mentsu.pai_list[0].type != mentsu3.pai_list[0].type && mentsu2.pai_list[0].type != mentsu3.pai_list[0].type
                      if mentsu.pai_list[0].number == mentsu3.pai_list[0].number                    
                        return true
                      end
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end
      
      ### 三色同刻
      def self.sanshokudouko?(tehai, agari); return false; end

      ### 対々和
      def self.toitoihou?(tehai, agari); return false; end

      ### 三暗刻
      def self.sanankou?(tehai, agari); return false; end
        
      ### 三槓子
      def self.sankantsu?(tehai, agari); return false; end
        
      ### 小三元
      def self.shousangen?(tehai, agari); return false; end
    end
  end
end
