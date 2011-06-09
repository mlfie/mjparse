# -*- coding: utf-8 -*-

require 'mjt/analysis/yaku_judger_one.rb'
require 'mjt/analysis/yaku_judger_two.rb'
require 'mjt/analysis/yaku_judger_three_six.rb'
require 'mjt/analysis/yaku_judger_man.rb'
	
module Mjt
  module Analysis
    class YakuJudger

      def self.set_yaku_list(tehai, agari)
        yaku_list = Array.new
    
        # 役満から判定していく
        yaku_list << Yaku.find_by_name("daisangen")       if  daisangen?(tehai, agari)

        # 役満は該当したらreturn
        if yaku_list.size > 0
          return
        end

        yaku_list << Yaku.find_by_name("ippatsu")         if  ippatsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("tanyao")          if  tanyao?(tehai, agari)
        yaku_list << Yaku.find_by_name("pinfu")           if  pinfu?(tehai, agari)
        yaku_list << Yaku.find_by_name("sanshoku")        if  sanshoku?(tehai, agari)
        yaku_list << Yaku.find_by_name("sanshokudouko")   if  sanshokudouko?(tehai, agari)
        yaku_list << Yaku.find_by_name("iipeikou")        if  iipeikou?(tehai, agari)
        yaku_list << Yaku.find_by_name("tsumo")           if  tsumo?(tehai, agari)
        yaku_list << Yaku.find_by_name("haku")            if  haku?(tehai, agari)
        yaku_list << Yaku.find_by_name("hatsu")           if  hatsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("chun")            if  chun?(tehai, agari)
        yaku_list << Yaku.find_by_name("ton")             if  ton?(tehai, agari)
        yaku_list << Yaku.find_by_name("nan")             if  nan?(tehai, agari)
        yaku_list << Yaku.find_by_name("sha")             if  sha?(tehai, agari)
        yaku_list << Yaku.find_by_name("pei")             if  pei?(tehai, agari)
        yaku_list << Yaku.find_by_name("rinshan")         if  rinshan?(tehai, agari)
        yaku_list << Yaku.find_by_name("ikkitsukan")      if  ikkitsukan?(tehai, agari)
        yaku_list << Yaku.find_by_name("chanta")          if  chanta?(tehai, agari)
        yaku_list << Yaku.find_by_name("toitoihou")       if  toitoihou?(tehai, agari)
        yaku_list << Yaku.find_by_name("sanankou")        if  sanankou?(tehai, agari)
        yaku_list << Yaku.find_by_name("honroutou")       if  honroutou?(tehai, agari)
        yaku_list << Yaku.find_by_name("sankantsu")       if  sankantsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("shousangen")      if  shousangen?(tehai, agari)
        yaku_list << Yaku.find_by_name("doublereach")     if  doublereach?(tehai, agari)
        yaku_list << Yaku.find_by_name("chitoitsu")       if  chitoitsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("honitsu")         if  honitsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("junchan")         if  junchan?(tehai, agari)
        yaku_list << Yaku.find_by_name("ryanpeikou")      if  ryanpeikou?(tehai, agari)
        yaku_list << Yaku.find_by_name("chinitsu")        if  chinitsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("chankan")         if  chankan?(tehai, agari)
        yaku_list << Yaku.find_by_name("haitei")          if  haitei?(tehai, agari)
        yaku_list << Yaku.find_by_name("houtei")          if  houtei?(tehai, agari)
        yaku_list << Yaku.find_by_name("kokushi")         if  kokushi?(tehai, agari)
        yaku_list << Yaku.find_by_name("suuankou")        if  suuankou?(tehai, agari)

        tehai.yaku_list = yaku_list
      end
    end
  end
end
