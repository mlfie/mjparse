# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'

# 役判定（役満）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger

      # 国士無双
      def kokushi?(tehai, agari)
        return false
      end

      # 四暗刻
      def suankou?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          if mentsu.mentsu_type != 'k' 
            return false
          elsif !(mentsu.furo)
            return false	  
          end
        end
		    return true
      end
	  
      # 大三元
      def daisangen?(tehai, agari)
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
        end
          
		    if has_haku && has_chun && has_hatsu
          return true
        end
        return false
      end

      def sukantsu?(tehai, agari)
        count = 0
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "4"
		        count += 1
		      end
        end
		    if count > 3
		      return true
		    end
        return false
      end
	  
      def tenho?(tehai, agari)
        if agari.is_tenho
          return true
        end
		    return false
      end
	  
      def chiho?(tehai, agari)
        if agari.is_chiho
          return true
        end
		    return false
      end	   
	  
      def tasushi?(tehai, agari)
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == "k" && mentsu.pai_list[0].type == "j" && mentsu.pai_list[0].number == "1"
            tehai.mentsu_list.each do | mentsu2|
              if mentsu2.mentsu_type == "k" && mentsu2.pai_list[0].type == "j" && mentsu2.pai_list[0].number == "2"
                tehai.mentsu_list.each do | mentsu3|
                  if mentsu3.mentsu_type == "k" && mentsu3.pai_list[0].type == "j" && mentsu3.pai_list[0].number == "3"
                    tehai.mentsu_list.each do | mentsu4|
                      if mentsu4.mentsu_type == "k" && mentsu4.pai_list[0].type == "j" && mentsu4.pai_list[0].number == "4"
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
	  
      def shosushi?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type != "t" && mentsu.pai_list[0].type != "j" 
            tehai.mentsu_list.each do | mentsu2 |		  
              if mentsu2.pai_list[0].type == "j" && mentsu2.pai_list[0].number == "1"
                tehai.mentsu_list.each do | mentsu3 |
                  if mentsu3.pai_list[0].type == "j" && mentsu3.pai_list[0].number == "2"
                    tehai.mentsu_list.each do | mentsu4 |
                      if mentsu4.pai_list[0].type == "j" && mentsu4.pai_list[0].number == "3"
                        tehai.mentsu_list.each do | mentsu5 |
                          if mentsu5.pai_list[0].type == "j" && mentsu5.pai_list[0].number == "4"
                            return true
                          end
                        end
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
	  	  
      def tsuiso?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.pai_list[0].type != "j"
            return false
		      end
		    end
        return true
      end
	  
      def chinraoto?(tehai, agari)
        tehai.mentsu_list.each do | mentsu |
          if mentsu.pai_list[0].type != "j"
            if mentsu.mentsu_type != "k" && mentsu.mentsu_type != "t"
              return false
            elsif mentsu.pai_list[0].type != "1" || mentsu.pai_list[0].type != "9"
              return false
			end
	      end
	    end
		return true	  
	  end
	  
      def ryuiso?(tehai, agari); return false; end 
      def churen?(tehai, agari); return false; end
	  
	  
	  
  
    end
  end
end

