# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'

# 役判定（役満）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger

      # 国士無双
      def kokushi?(tehai, agari)
        # 頭とメンツで公九牌が13種類以上あること
        count = 0
        # m1
        if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_MANZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list do |pai|
              if pai.number == 1 && pai.type == Pai::PAI_TYPE_MANZU
                count += 1
              end
            end
          end
        end
        # m9
        if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_MANZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == 9 && pai.type == Pai::PAI_TYPE_MANZU
                count += 1
              end
            end
          end
        end
        # s1
        if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_SOUZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == 1 && pai.type == Pai::PAI_TYPE_SOUZU
                count += 1
              end
            end
          end
        end
        # s9
        if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_SOUZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == 9 && pai.type == Pai::PAI_TYPE_SOUZU
                count += 1
              end
            end
          end
        end
        # p1
        if tehai.atama.number == 1 && tehai.atama.type == Pai::PAI_TYPE_PINZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == 1 && pai.type == Pai::PAI_TYPE_PINZU
                count += 1
              end
            end
          end
        end
        # p9
        if tehai.atama.number == 9 && tehai.atama.type == Pai::PAI_TYPE_PINZU
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == 9 && pai.type == Pai::PAI_TYPE_PINZU
                count += 1
              end
            end
          end
        end
        # 東
        if tehai.atama.number == Pai::PAI_NUMBER_TON && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_TON && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 南
        if tehai.atama.number == Pai::PAI_NUMBER_NAN && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_NAN && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 西
        if tehai.atama.number == Pai::PAI_NUMBER_SHA && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_SHA && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 北
        if tehai.atama.number == Pai::PAI_NUMBER_PEI && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_PEI && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 白
        if tehai.atama.number == Pai::PAI_NUMBER_HAKU && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_HAKU && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 発
        if tehai.atama.number == Pai::PAI_NUMBER_HATSU && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_HATSU && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end
        # 中
        if tehai.atama.number == Pai::PAI_NUMBER_CHUN && tehai.atama.type == Pai::PAI_TYPE_JIHAI
          count += 1
        else
          tehai.mentsu_list.each do |mentsu|
            mentsu.pai_list.each do |pai|
              if pai.number == Pai::PAI_NUMBER_CHUN && pai.type == Pai::PAI_TYPE_JIHAI
                count += 1
              end
            end
          end
        end

        if count >= 12
          return true
        end
                
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
      
      # 四槓子
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
	  
	  # 天和
      def tenho?(tehai, agari)
        if agari.is_tenho
          return true
        end
		  return false
      end
	  
	  # 地和
      def chiho?(tehai, agari)
        if agari.is_chiho
          return true
        end
		  return false
      end	   
	  
	  # 大四喜
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
	  
	  # 小四喜
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
	  
	  # 字一色	  
      def tsuiso?(tehai, agari)
        tehai.mentsu_list.each do |mentsu|
          mentsu.pai_list.each do |pai|
            if pai.type != Pai::PAI_TYPE_JIHAI
              return false
		    end
		  end
		end
		 
        return true
      end
	  
	  # 清老頭
      def chinraoto?(tehai, agari)
        return false
#        tehai.mentsu_list.each do | mentsu |
#          if mentsu.pai_list[0].type != "j"
#            if mentsu.mentsu_type != "k" && mentsu.mentsu_type != "t"
#              return false
#            elsif mentsu.pai_list[0].type != "1" || mentsu.pai_list[0].type != "9"
#              return false
#			end
#	      end
#	    end
#		return true	  
	  end
	  
	  # 緑一色
      def ryuiso?(tehai, agari); return false; end 
      
      # 九蓮宝燈
      def churen?(tehai, agari); return false; end
	  
	  
	  
  
    end
  end
end

