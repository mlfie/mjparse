# -*- coding: utf-8 -*-
	
require 'mjt/analysis/teyaku_decider'

module Mjt
module Analysis
class YakuJudger

  def self.set_yaku_list(result, agari)

    yaku_list = Array.new

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
  def  self.pinfu?(result, agari); return false; end
  def  self.sanshoku?(result, agari); return false; end
  def  self.sanshokudouko?(result, agari); return false; end
  def  self.iipeikou?(result, agari); return false; end
  def  self.tsumo?(result, agari); return false; end
  def  self.haku?(result, agari); return false; end
  def  self.hatsu?(result, agari); return false; end
  def  self.chun?(result, agari); return false; end
  def  self.ton?(result, agari); return false; end
  def  self.nan?(result, agari); return false; end
  def  self.sha?(result, agari); return false; end
  def  self.pei?(result, agari); return false; end
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
  def  self.chinitsu?(result, agari); return false; end
  def  self.chankan?(result, agari); return false; end
  def  self.haitei?(result, agari); return false; end
  def  self.houtei?(result, agari); return false; end
  def  self.kokushi?(result, agari); return false; end
  def  self.suuankou?(result, agari); return false; end

end
end
end
