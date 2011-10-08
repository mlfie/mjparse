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
      def self.junchan?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type = k || mentsu.mentsu_type = t
		      if mentsu.pai_list[0].type = j
				return false
			　 elseif mentsu.pai_list[0].number != 1 && mentsu.pai_list[0].number != 9
				return false
			  end	 
		  end
		  
		  if mentsu.mentsu_type = s
		     if mentsu.pai_list[0].number != "1" && mentsu.pai_list[0].number != "7"
			   return false
			 end
		  end
		  
		  if mentsu.mentsu_type = y
		    return false
		  end
		  
		end  
		return true
	  end
	  
	  
      ### 混老頭
      def self.honroutou?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
            if mentsu.mentsu_type = k || mentsu.mentsu_type = t
		      if mentsu.pai_list[0].type != j
				if mentsu.pai_list[0].number != 1 && mentsu.pai_list[0].number != 9
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
