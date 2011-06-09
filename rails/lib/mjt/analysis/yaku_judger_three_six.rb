# -*- coding: utf-8 -*-

# 役判定（3飜〜6飜）を行うクラスメソッド群
module Mjt
  module Analysis
    class YakuJudger
      ### 二盃口
      def self.ryanpeikou?(tehai, agari); return false; end
      
      ### 混一色
      def self.honitsu?(tehai, agari)
        beforetype = nil
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.type == "j" then
              next
            elsif pai.type == beforetype || beforetype == nil
              next
            else
              return false
            end
          end
        end
        return true
      end
      
      ### 純全帯么九
      def self.junchan?(tehai, agari); return false; end
        
      ### 混老頭
      def self.honroutou?(tehai, agari); return false; end
        
      ### 清一色
      def self.chinitsu?(tehai, agari)
        beforetype = nil
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if beforetype == nil then
              beforetype = pai.type
            elsif beforetype != pai.type || pai.type == "j"
              return false
            end
          end
        end
        return true
      end
    end
  end
end
