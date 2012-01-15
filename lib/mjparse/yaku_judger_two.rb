# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'pai')
require File.join(File.dirname(__FILE__), 'mentsu')

# 役判定（2飜）を行うクラスメソッド群
module Mjparse
  module YakuJudgerTwo
    ### ダブル立直
    def doublereach?(tehai, kyoku)
      kyoku.doublereach?
    end

    ### 七対子
    def chitoitsu?(tehai, kyoku)
      tehai.mentsu_list.size == 6
    end

    ### 混全帯么九
    def chanta?(tehai, kyoku)
      # 頭と全ての面子がヤオチュウ牌であること
      return false unless tehai.atama.yaochu? and tehai.mentsu_list.all? {|mentsu| mentsu.yaochu? }

      # 必ず一つは字牌があること
      return false unless tehai.atama.jihai? or tehai.mentsu_list.any?{|mentsu| mentsu.jihai? }

      # 必ず一つは数牌があること
      return false unless tehai.atama.suhai? or tehai.mentsu_list.any?{|mentsu| mentsu.suhai? }

      # 必ず一つは順子があること
      return false unless tehai.mentsu_list.any?{|mentsu| mentsu.shuntsu? }

      return true
    end

    ### 一気通貫
    def ikkitsukan?(tehai, kyoku)
      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #マンズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.manzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #ソウズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.souzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      flag_onetwothree = false
      flag_fourfivesix = false
      flag_seveneightnine = false
      
      #ピンズ
      tehai.shuntsu_list.each do |mentsu|
        if mentsu.identical.pinzu?
          case mentsu.identical.number
          when 1
            flag_onetwothree = true  
          when 4
            flag_fourfivesix = true
          when 7
            flag_seveneightnine = true
          end
        end
      end       
      if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
        return true
      end

      return false
    end

    ### 三色同順
    def sanshoku?(tehai, kyoku)
      tehai.shuntsu_list.each do |mentsu|
        tehai.shuntsu_list.each do |mentsu2|
          next unless mentsu.identical.type != mentsu2.identical.type
          next unless mentsu.identical.number == mentsu2.identical.number
          tehai.shuntsu_list.each do |mentsu3|
            next unless mentsu.identical.type != mentsu3.identical.type && mentsu2.identical.type != mentsu3.identical.type
            return true if mentsu.identical.number == mentsu3.identical.number                    
          end
        end 
      end
      return false
    end
    
    ### 三色同刻
    def sanshokudouko?(tehai, kyoku)
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
    def toitoihou?(tehai, kyoku)
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
    def sanankou?(tehai, kyoku)
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
    def sankantsu?(tehai, kyoku)
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
    def shousangen?(tehai, kyoku)
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
    def honroutou?(tehai, kyoku)
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
