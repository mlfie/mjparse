# -*- coding: utf-8 -*-
	
require 'mjt/analysis/teyaku_decider'

module Mjt
module Analysis
class YakuJudger

  def self.set_yaku_list(result, agari)

    yaku_list = Array.new
    
    # 役満は該当したらreturn
    if daisangen?(result, agari)
      yaku_list << Yaku.find_by_name("daisangen")
      return
    end

 yaku_list << Yaku.find_by_name("ippatsu")   if  ippatsu?(result, agari)
 yaku_list << Yaku.find_by_name("tanyao")   if  tanyao?(result, agari)
 yaku_list << Yaku.find_by_name("pinfu")   if  pinfu?(result, agari)
 yaku_list << Yaku.find_by_name("sanshoku")   if  sanshoku?(result, agari)
 yaku_list << Yaku.find_by_name("sanshokudouko")   if  sanshokudouko?(result, agari)
 yaku_list << Yaku.find_by_name("iipeikou")   if  iipeikou?(result, agari)
 yaku_list << Yaku.find_by_name("tsumo")   if  tsumo?(result, agari)
 yaku_list << Yaku.find_by_name("haku")   if  haku?(result, agari)
 yaku_list << Yaku.find_by_name("hatsu")   if  hatsu?(result, agari)
 yaku_list << Yaku.find_by_name("chun")   if  chun?(result, agari)
 yaku_list << Yaku.find_by_name("ton")   if  ton?(result, agari)
 yaku_list << Yaku.find_by_name("nan")   if  nan?(result, agari)
 yaku_list << Yaku.find_by_name("sha")   if  sha?(result, agari)
 yaku_list << Yaku.find_by_name("pei")   if  pei?(result, agari)
 yaku_list << Yaku.find_by_name("rinshan")   if  rinshan?(result, agari)
 yaku_list << Yaku.find_by_name("ikkitsukan")   if  ikkitsukan?(result, agari)
 yaku_list << Yaku.find_by_name("chanta")   if  chanta?(result, agari)
 yaku_list << Yaku.find_by_name("toitoihou")   if  toitoihou?(result, agari)
 yaku_list << Yaku.find_by_name("sanankou")   if  sanankou?(result, agari)
 yaku_list << Yaku.find_by_name("honroutou")   if  honroutou?(result, agari)
 yaku_list << Yaku.find_by_name("sankantsu")   if  sankantsu?(result, agari)
 yaku_list << Yaku.find_by_name("shousangen")   if  shousangen?(result, agari)
 yaku_list << Yaku.find_by_name("doublereach")   if  doublereach?(result, agari)
 yaku_list << Yaku.find_by_name("chitoitsu")   if  chitoitsu?(result, agari)
 yaku_list << Yaku.find_by_name("honitsu")   if  honitsu?(result, agari)
 yaku_list << Yaku.find_by_name("junchan")   if  junchan?(result, agari)
 yaku_list << Yaku.find_by_name("ryanpeikou")   if  ryanpeikou?(result, agari)
 yaku_list << Yaku.find_by_name("chinitsu")   if  chinitsu?(result, agari)
 yaku_list << Yaku.find_by_name("chankan")   if  chankan?(result, agari)
 yaku_list << Yaku.find_by_name("haitei")   if  haitei?(result, agari)
 yaku_list << Yaku.find_by_name("houtei")   if  houtei?(result, agari)
 yaku_list << Yaku.find_by_name("kokushi")   if  kokushi?(result, agari)
 yaku_list << Yaku.find_by_name("suuankou")   if  suuankou?(result, agari)


    result.yaku_list = yaku_list
  end

  #以下役判定用内部呼び出しメソッド郡


  def  self.reach?(result, agari); return false; end
  def  self.ippatsu?(result, agari); return false; end
  def self.tanyao?(result, agari)
    if result.atama.yaochu?
      return false
    end
    result.mentsu_list.each do |mentsu|
      mentsu.pai_list.each do | pai |
        if pai.yaochu?
          return false
        end
      end
    end
    return true
  end
  def  self.pinfu?(result, agari)
  		#コーツなし判定
		result.mentsu_list.each do |mentsu|
				if mentsu.pai_list[0].number == mentsu.pai_list[1].number || mentsu.pai_list[1].number == mentsu.pai_list[2].number
					return false
				end
		end
			
		#対子が風・三元牌でナシ判定
		kazemap = [["ton", 1], ["nan", 2], ["sya", 3], ["pei", 4]]
		
		kazemap.each do | ibakaze |
			if agari.bakaze == ibakaze[0] && result.atama.number == ibakaze[1] 
				return false
			end
		end
				
		kazemap.each do | ijikaze |
			if agari.jikaze == ijikaze[0] && result.atama.number == ijikaze[1] 
				return false
			end
		end
				
		if result.atama.number == 5 || result.atama.number == 6 || result.atama.number == 7
			return false
		end

		# 両面で待っていることを判定
		if result.atama.agari == true
			return false
		end
			
		result.mentsu_list.each do |mentsu|
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
  def  self.sanshoku?(result, agari)
		result.mentsu_list.each do | mentsu|
			if mentsu.mentsu_type == "s"
				result.mentsu_list.each do | mentsu2|
					if mentsu2.mentsu_type == "s" && mentsu.pai_list[0].type != mentsu2.pai_list[0].type
						if mentsu.pai_list[0].number == mentsu2.pai_list[0].number
							result.mentsu_list.each do | mentsu3|
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
  def  self.sanshokudouko?(result, agari); return false; end
  
  def  self.iipeikou?(result, agari) 
    result.mentsu_list.each_with_index do |mentsu_1,i|
      result.mentsu_list.each_with_index do |mentsu_2,j|
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

  def  self.tsumo?(result, agari); return false; end
  def  self.haku?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 5
      end 
      return true if count == 3
    end
    return false
  end


  def  self.hatsu?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 6
      end 
      return true if count == 3
    end
    return false
  end

  def  self.chun?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 7
      end 
      return true if count == 3
    end
    return false
  end

  def  self.ton?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 1
      end 
      return true if count == 3
    end
    return false
  end


  def  self.nan?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 2
      end 
      return true if count == 3
    end
    return false
  end

  def  self.sha?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 3
      end 
      return true if count == 3
    end
    return false
  end

  def  self.pei?(result, agari)
    result.mentsu_list.each do |mentsu|
      count = 0 
      mentsu.pai_list.each do |pai| 
        count += 1 if pai.type == "j" && pai.number == 4
      end 
      return true if count == 3
    end
    return false
  end

  def  self.rinshan?(result, agari); return false; end
  def  self.ikkitsukan?(result, agari); return false; end
  def  self.chanta?(result, agari); return false; end
  def  self.toitoihou?(result, agari); return false; end
  def  self.sanankou?(result, agari); return false; end
  def  self.honroutou?(result, agari); return false; end
  def  self.sankantsu?(result, agari); return false; end
  def  self.shousangen?(result, agari); return false; end
  def  self.doublereach?(result, agari); return false; end
  def  self.chitoitsu?(result, agari); return false; end
  def  self.honitsu?(result, agari); return false; end
  def  self.junchan?(result, agari); return false; end
  def  self.ryanpeikou?(result, agari); return false; end


  def  self.chinitsu?(result, agari)
    beforetype = nil
    result.mentsu_list.each do |mentsu|
      mentsu.pai_list.each do |pai| 
        if ( pai.type == "j" || 
             ( pai.type != beforetype &&  pai.type != nil ) )
           return false
        else
          beforetype = pai.type
        end
      end 
    end
    return true
  end


  def  self.chankan?(result, agari); return false; end
  def  self.haitei?(result, agari); return false; end
  def  self.houtei?(result, agari); return false; end
  def  self.kokushi?(result, agari); return false; end
  def  self.suuankou?(result, agari); return false; end
    def self.daisangen?(result, agari)
      has_haku = false
      has_chun = false
      has_hatsu = false
      
      result.mentsu_list.each do |metsu|
        if metsu.mentsu_type == 'k'
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
