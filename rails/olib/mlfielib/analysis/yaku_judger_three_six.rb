# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'

# 役判定（3飜〜6飜）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger
    
      ### 二盃口
      def ryanpeikou?(tehai, agari)
        ryanpeikou_count = 0
        tehai.mentsu_list.each_with_index do |mentsu_1,i|
          tehai.mentsu_list.each_with_index do |mentsu_2,j|
            if i != j && mentsu_1.shuntsu? && mentsu_2.shuntsu?
              ipeikou_count = 0
              [0,1,2].each do |k|
                if mentsu_1.pai_list[k].type == mentsu_2.pai_list[k].type && mentsu_1.pai_list[k].number == mentsu_2.pai_list[k].number
                  ipeikou_count += 1
                end
              end
              if ipeikou_count == 3 
                ryanpeikou_count += 1
              end
            end # end if
          end # end each
        end # end each
        if ryanpeikou_count == 4
          return true
        end
        return false
      end
      
      ### 混一色
      def honitsu?(tehai, agari)
      fetchtype = nil
        tehai.mentsu_list.each do | mentsu |		
          if mentsu.pai_list[0].type != "j"
            fetchtype = mentsu.pai_list[0].type
          end
        end  
        if fetchtype == nil
          return false
        end

        tehai.mentsu_list.each do | mentsu2 |		
          if mentsu2.pai_list[0].type != "j" && mentsu2.pai_list[0].type != fetchtype
            return false
           end
        end
        return true
      end
      
#        beforetype = nil
#        tehai.mentsu_list.each do |mentsu|
#          mentsu.pai_list.each do |pai|
#            if pai.type == "j" then
#              next
#            elsif pai.type == beforetype || beforetype == nil
#              next
#            else
#              return false
#            end
#          end
#        end
#        return true
#      end
      
      ### 純全帯么九
      def junchan?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == "k" || mentsu.mentsu_type == "4"
            if mentsu.pai_list[0].type == "j"
              return false
            elsif mentsu.pai_list[0].number != "1"
              if mentsu.pai_list[0].number != "9"
                return false
              end
            end	 
          end
          if mentsu.mentsu_type == "s"
            if mentsu.pai_list[0].number != "1"
              if mentsu.pai_list[0].number != "7"
                return false
              end
            end
          end
          if mentsu.mentsu_type == "y"
            return false
          end
          if tehai.atama.type == "j"
            return false
          elsif tehai.atama.number != "1"
            if tehai.atama.number != "9"
              return false
            end
          end
        end  
        return true
      end
  
      ### 清一色
      def chinitsu?(tehai, agari)
        beforetype = nil
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if beforetype == nil then
              beforetype = pai.type
            elsif beforetype != pai.type
              return false
            end
          end
        end
        if tehai.atama.type != beforetype
          return false
        end
        return true
      end
  
    end
  end
end
