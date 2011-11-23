# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'

# 役判定（3飜〜6飜）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger
      ### 二盃口
      def ryanpeikou?(tehai, agari); return false; end
      
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
	
    #後で消す処理。清一の場合falseにする
    flag = 0
        tehai.mentsu_list.each do | mentsu3 |		
      if mentsu3.pai_list[0].type != fetchtype
        flag = 1
      end
    end		
    if flag == 0
      return false
    end
    #後で消す処理。ここまで


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
          if mentsu.mentsu_type == "k" || mentsu.mentsu_type == "t"
            if mentsu.pai_list[0].type == "j"
              return false
            elsif mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "9"
              return false
            end	 
          end
          if mentsu.mentsu_type == "s"
            if mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "7"
              return false
            end
          end
          if mentsu.mentsu_type == "y"
            return false
          end
        end  
        return true
      end


      ### 混老頭
      def honroutou?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == "k" || mentsu.mentsu_type == "t"
            if mentsu.pai_list[0].type != "j"
              if mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "9"
                return false
               end
            end
          else
            return false
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
        return true
      end
  
    end
  end
end
