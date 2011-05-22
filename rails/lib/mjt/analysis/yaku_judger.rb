# -*- coding: utf-8 -*-
	
require 'mjt/analysis/teyaku_decider'

module Mjt
module Analysis
class YakuJudger

  def self.set_yaku_list(tehai, agari)

    yaku_list = Array.new
    
    # 役満は該当したらreturn
    if daisangen?(tehai, agari)
      yaku_list << Yaku.find_by_name("daisangen")
      return
    end

 yaku_list << Yaku.find_by_name("ippatsu")   if  ippatsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("tanyao")   if  tanyao?(tehai, agari)
 yaku_list << Yaku.find_by_name("pinfu")   if  pinfu?(tehai, agari)
 yaku_list << Yaku.find_by_name("sanshoku")   if  sanshoku?(tehai, agari)
 yaku_list << Yaku.find_by_name("sanshokudouko")   if  sanshokudouko?(tehai, agari)
 yaku_list << Yaku.find_by_name("iipeikou")   if  iipeikou?(tehai, agari)
 yaku_list << Yaku.find_by_name("tsumo")   if  tsumo?(tehai, agari)
 yaku_list << Yaku.find_by_name("haku")   if  haku?(tehai, agari)
 yaku_list << Yaku.find_by_name("hatsu")   if  hatsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("chun")   if  chun?(tehai, agari)
 yaku_list << Yaku.find_by_name("ton")   if  ton?(tehai, agari)
 yaku_list << Yaku.find_by_name("nan")   if  nan?(tehai, agari)
 yaku_list << Yaku.find_by_name("sha")   if  sha?(tehai, agari)
 yaku_list << Yaku.find_by_name("pei")   if  pei?(tehai, agari)
 yaku_list << Yaku.find_by_name("rinshan")   if  rinshan?(tehai, agari)
 yaku_list << Yaku.find_by_name("ikkitsukan")   if  ikkitsukan?(tehai, agari)
 yaku_list << Yaku.find_by_name("chanta")   if  chanta?(tehai, agari)
 yaku_list << Yaku.find_by_name("toitoihou")   if  toitoihou?(tehai, agari)
 yaku_list << Yaku.find_by_name("sanankou")   if  sanankou?(tehai, agari)
 yaku_list << Yaku.find_by_name("honroutou")   if  honroutou?(tehai, agari)
 yaku_list << Yaku.find_by_name("sankantsu")   if  sankantsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("shousangen")   if  shousangen?(tehai, agari)
 yaku_list << Yaku.find_by_name("doublereach")   if  doublereach?(tehai, agari)
 yaku_list << Yaku.find_by_name("chitoitsu")   if  chitoitsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("honitsu")   if  honitsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("junchan")   if  junchan?(tehai, agari)
 yaku_list << Yaku.find_by_name("ryanpeikou")   if  ryanpeikou?(tehai, agari)
 yaku_list << Yaku.find_by_name("chinitsu")   if  chinitsu?(tehai, agari)
 yaku_list << Yaku.find_by_name("chankan")   if  chankan?(tehai, agari)
 yaku_list << Yaku.find_by_name("haitei")   if  haitei?(tehai, agari)
 yaku_list << Yaku.find_by_name("houtei")   if  houtei?(tehai, agari)
 yaku_list << Yaku.find_by_name("kokushi")   if  kokushi?(tehai, agari)
 yaku_list << Yaku.find_by_name("suuankou")   if  suuankou?(tehai, agari)


    tehai.yaku_list = yaku_list
  end

  #以下役判定用内部呼び出しメソッド郡


  def  self.reach?(tehai, agari); return false; end
  def  self.ippatsu?(tehai, agari); return false; end
  def self.tanyao?(tehai, agari)
    if tehai.atama.yaochu?
      return false
    end
    tehai.mentsu_list.each do |mentsu|
      mentsu.pai_list.each do | pai |
        if pai.yaochu?
          return false
        end
      end
    end
    return true
  end
  def  self.pinfu?(tehai, agari)
  		#コーツなし判定
		tehai.mentsu_list.each do |mentsu|
				if mentsu.pai_list[0].number == mentsu.pai_list[1].number || mentsu.pai_list[1].number == mentsu.pai_list[2].number
					return false
				end
		end
			
		#対子が風・三元牌でナシ判定
		kazemap = [["ton", 1], ["nan", 2], ["sya", 3], ["pei", 4]]
		
		kazemap.each do | ibakaze |
			if agari.bakaze == ibakaze[0] && tehai.atama.number == ibakaze[1] 
				return false
			end
		end
				
		kazemap.each do | ijikaze |
			if agari.jikaze == ijikaze[0] && tehai.atama.number == ijikaze[1] 
				return false
			end
		end
				
		if tehai.atama.type == "j" && (tehai.atama.number == 5 || tehai.atama.number == 6 || tehai.atama.number == 7)
			return false
		end

		# 両面で待っていることを判定
		if tehai.atama.agari == true
			return false
		end
			
		tehai.mentsu_list.each do |mentsu|
			if mentsu.pai_list[1].agari == true
				return false
			end
				
			if mentsu.pai_list[0].agari == true && mentsu.pai_list[2].number == 9
				return false
			end
						
			if mentsu.pai_list[2].agari == true && mentsu.pai_list[0].number == 1
				return false
			end
					
		end
				
		return true
  end
  def  self.sanshoku?(tehai, agari)
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
  def  self.sanshokudouko?(tehai, agari); return false; end
  
  def  self.iipeikou?(tehai, agari) 
    tehai.mentsu_list.each_with_index do |mentsu_1,i|
      tehai.mentsu_list.each_with_index do |mentsu_2,j|
        if i != j
          count=0
          [0,1,2].each do |k|
            if mentsu_1.pai_list[k] == mentsu_2.pai_list[k]
              count += 1
            end
          end
          if count == 3 
            return true
          end
        end # end if
      end # end each
    end # end each
    return false
  end # end def

  def  self.tsumo?(tehai, agari); return false; end

  def  self.haku?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 5
      end 
      return true if count == 3
    end
    return false
  end


  def  self.hatsu?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 6
      end 
      return true if count == 3
    end
    return false
  end

  def  self.chun?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 7
      end 
      return true if count == 3
    end
    return false
  end

  def  self.ton?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 1
      end 
      return true if count == 3
    end
    return false
  end


  def  self.nan?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 2
      end 
      return true if count == 3
    end
    return false
  end

  def  self.sha?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 3
      end 
      return true if count == 3
    end
    return false
  end

  def  self.pei?(tehai, agari)
    tehai.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 4
      end 
      return true if count == 3
    end
    return false
  end

  def  self.rinshan?(tehai, agari); return false; end
  def  self.ikkitsukan?(tehai, agari); return false; end
  def  self.chanta?(tehai, agari); return false; end
  def  self.toitoihou?(tehai, agari); return false; end
  def  self.sanankou?(tehai, agari); return false; end
  def  self.honroutou?(tehai, agari); return false; end
  def  self.sankantsu?(tehai, agari); return false; end
  def  self.shousangen?(tehai, agari); return false; end
  def  self.doublereach?(tehai, agari); return false; end
  def  self.chitoitsu?(tehai, agari); return false; end

  def  self.honitsu?(tehai, agari)
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


  def  self.junchan?(tehai, agari); return false; end
  def  self.ryanpeikou?(tehai, agari); return false; end


  def  self.chinitsu?(tehai, agari)
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


  def  self.chankan?(tehai, agari); return false; end
  def  self.haitei?(tehai, agari); return false; end
  def  self.houtei?(tehai, agari); return false; end
  def  self.kokushi?(tehai, agari); return false; end
  def  self.suuankou?(tehai, agari); return false; end
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
