# -*- coding: utf-8 -*-
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'

# 役判定（2飜）を行うクラスメソッド群
module Mlfielib
  module Analysis
    class YakuJudger
      ### ダブル立直
      def doublereach?(tehai, agari)
        if agari.reach_num == 2
          return true
        end
        return false
      end

      ### 七対子
      def chitoitsu?(tehai, agari)
	    if tehai.mentsu_list.size == 6
           return true
        end
        return false
      end

      ### 混全帯么九
      def chanta?(tehai, agari)
	    jihai_count = 0
		kotsu_count = 0
		
	    #雀頭に字牌が含まれているかをチェック
	    if tehai.atama.type == Pai::PAI_TYPE_JIHAI
		  jihai_count += 1
		end
        
        tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU || mentsu.mentsu_type == Mentsu::MENTSU_TYPE_TOITSU
		    if mentsu.pai_list[0].type != Pai::PAI_TYPE_JIHAI 
              if mentsu.pai_list[0].number != 1 && mentsu.pai_list[0].number != 9
                return false
		  	  else
                kotsu_count += 1
			  end
		    else
              jihai_count += 1
		      kotsu_count += 1
            end			 
	      end
		  
		  if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU
		    if mentsu.pai_list[0].number != 1 && mentsu.pai_list[0].number != 7
		      return false
		    end
		  end
		  
		  if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_TOKUSYU
		    return false
		  end
        end #each end

        ### ホンラオトーでないかつ、ジュンチャンでない
        if jihai_count != 0 && kotsu_count != 5
		    return true
		  end
		return false
        
      end #method end

      ### 一気通貫
      def ikkitsukan?(tehai, agari)
        flag_onetwothree = false
        flag_fourfivesix = false
        flag_seveneightnine = false
        
        #マンズ
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 1 && mentsu.pai_list[0].type == Pai::PAI_TYPE_MANZU
            flag_onetwothree = true  
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 4 && mentsu.pai_list[0].type == Pai::PAI_TYPE_MANZU
            flag_fourfivesix = true
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 7 && mentsu.pai_list[0].type == Pai::PAI_TYPE_MANZU          
            flag_seveneightnine = true
          end
        end       
        if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
          return true
        end
        flag_onetwothree = false
        flag_fourfivesix = false
        flag_seveneightnine = false
        #ソウズ
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 1 && mentsu.pai_list[0].type == Pai::PAI_TYPE_SOUZU
            flag_onetwothree = true  
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 4 && mentsu.pai_list[0].type == Pai::PAI_TYPE_SOUZU
            flag_fourfivesix = true
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 7 && mentsu.pai_list[0].type == Pai::PAI_TYPE_SOUZU        
            flag_seveneightnine = true
          end
        end       
        if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
          return true
        end
        flag_onetwothree = false
        flag_fourfivesix = false
        flag_seveneightnine = false
        #ピンズ
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 1 && mentsu.pai_list[0].type == Pai::PAI_TYPE_PINZU
            flag_onetwothree = true  
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 4 && mentsu.pai_list[0].type == Pai::PAI_TYPE_PINZU
            flag_fourfivesix = true
          end
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].number == 7 && mentsu.pai_list[0].type == Pai::PAI_TYPE_PINZU    
            flag_seveneightnine = true
          end
        end       
        if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
          return true
        end
        
        #other
        return false
      end

      ### 三色同順
      def sanshoku?(tehai, agari)
        tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU
            tehai.mentsu_list.each do | mentsu2|
              if mentsu2.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].type != mentsu2.pai_list[0].type
                if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
                  tehai.mentsu_list.each do | mentsu3|
                    if mentsu3.mentsu_type == Mentsu::MENTSU_TYPE_SHUNTSU && mentsu.pai_list[0].type != mentsu3.pai_list[0].type && mentsu2.pai_list[0].type != mentsu3.pai_list[0].type
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
      def sanshokudouko?(tehai, agari)
	    tehai.mentsu_list.each do | mentsu |
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU || mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU
            tehai.mentsu_list.each do | mentsu2 |
              if mentsu2.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU  || mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU
			    if mentsu.pai_list[0].type != mentsu2.pai_list[0].type
                  if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
                    tehai.mentsu_list.each do | mentsu3 |
                      if mentsu3.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU || mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU
					    if mentsu.pai_list[0].type != mentsu3.pai_list[0].type && mentsu2.pai_list[0].type != mentsu3.pai_list[0].type
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
          end
		end  
		return false
      end

      ### 対々和
      def toitoihou?(tehai, agari)
        if tehai.mentsu_list.size == 4
		  tehai.mentsu_list.each do | mentsu| 
		    if mentsu.mentsu_type != Mentsu::MENTSU_TYPE_KOUTSU
     		  if mentsu.mentsu_type != Mentsu::MENTSU_TYPE_TOITSU
			    return false
			  end
			end
          end
          return true		  
		end
		return false
      end

      ### 三暗刻
      def sanankou?(tehai, agari)
	    count = 0
	    tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU && mentsu.furo == false
		    count += 1
		  end
		end
		if count > 2
		  return true
		end
	    return false
	  end
        
      ### 三槓子
      def sankantsu?(tehai, agari)
	    count = 0
	    tehai.mentsu_list.each do | mentsu|
          if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU
		    count += 1
		  end
		end
		if count == 3
		  return true
		end
	    return false
      end
	  
        
      ### 小三元
      def shousangen?(tehai, agari)
        #頭が三元牌じゃなかったらfalse
        if tehai.atama.type != Pai::PAI_TYPE_JIHAI
          return false
        end
        if tehai.atama.number != Pai::PAI_NUMBER_HAKU && tehai.atama.number != Pai::PAI_NUMBER_HATSU && tehai.atama.number != Pai::PAI_NUMBER_CHUN
          return false
        end
        
        #三元牌の刻子、槓子があること
        has_haku = false
        has_hatsu =false
        has_chun = false
        # 白
        tehai.mentsu_list.each do | mentsu|
          if mentsu.koutsu? || mentsu.kantsu?
            if mentsu.pai_list[0].number == Pai::PAI_NUMBER_HAKU && mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI
              has_haku = true
            end
          end
        end
        # 発
        tehai.mentsu_list.each do | mentsu|
          if mentsu.koutsu? || mentsu.kantsu?
            if mentsu.pai_list[0].number == Pai::PAI_NUMBER_HATSU && mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI
              has_hatsu = true
            end
          end
        end        
        # 中
        tehai.mentsu_list.each do | mentsu|
          if mentsu.koutsu? || mentsu.kantsu?
            if mentsu.pai_list[0].number == Pai::PAI_NUMBER_CHUN && mentsu.pai_list[0].type == Pai::PAI_TYPE_JIHAI
              has_chun = true
            end
          end
        end
       
       if (has_haku && has_hatsu) || (has_haku && has_chun) || (has_hatsu && has_chun) 
         return true
       end
	   
	   return false
      end
      
      ### 混老頭
      def honroutou?(tehai, agari)
        if tehai.atama.type != Pai::PAI_TYPE_JIHAI
          if tehai.atama.number != 1 && tehai.atama.number != 9
            return false
          end
        end
        tehai.mentsu_list.each do | mentsu |
            if mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KOUTSU || mentsu.mentsu_type == Mentsu::MENTSU_TYPE_KANTSU
		      if mentsu.pai_list[0].type != Pai::PAI_TYPE_JIHAI
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
	  
	  
    end
  end
end
