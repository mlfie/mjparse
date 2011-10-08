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
 #       yaku_list << Yaku.find_by_name("daisangen")       if  daisangen?(tehai, agari)
        yaku_list << Yaku.find_by_name("kokushi")         if  kokushi?(tehai, agari)
        yaku_list << Yaku.find_by_name("suankou")        if  suankou?(tehai, agari)		
		yaku_list << Yaku.find_by_name("sukantsu")       if  sukantsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("tenho")        if  tenho?(tehai, agari)
        yaku_list << Yaku.find_by_name("chiho")        if  chiho?(tehai, agari)
        yaku_list << Yaku.find_by_name("tasushi")        if  tasushi?(tehai, agari)
        yaku_list << Yaku.find_by_name("shosushi")        if  shosushi?(tehai, agari)
        yaku_list << Yaku.find_by_name("tsuiso")        if  tsuiso?(tehai, agari)
        yaku_list << Yaku.find_by_name("chinraoto")        if  chinraoto?(tehai, agari)
        yaku_list << Yaku.find_by_name("ryuiso")        if  ryuiso?(tehai, agari)
        yaku_list << Yaku.find_by_name("churen")        if  churen?(tehai, agari)	
        # 役満は該当したらreturn
        if yaku_list.size > 0
		  tehai.yaku_list = yaku_list
          return
        end

		# 1ファン
		yaku_list << Yaku.find_by_name("reach")         if  reach?(tehai, agari)
        yaku_list << Yaku.find_by_name("ippatsu")         if  ippatsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("tanyao")          if  tanyao?(tehai, agari)
        yaku_list << Yaku.find_by_name("pinfu")           if  pinfu?(tehai, agari)
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
		yaku_list << Yaku.find_by_name("chankan")         if  chankan?(tehai, agari)
        yaku_list << Yaku.find_by_name("haitei")          if  haitei?(tehai, agari)
        yaku_list << Yaku.find_by_name("houtei")          if  houtei?(tehai, agari)
		# 2ファン
        yaku_list << Yaku.find_by_name("ikkitsukan")      if  ikkitsukan?(tehai, agari)
        yaku_list << Yaku.find_by_name("chanta")          if  chanta?(tehai, agari)
        yaku_list << Yaku.find_by_name("toitoihou")       if  toitoihou?(tehai, agari)
        yaku_list << Yaku.find_by_name("sanankou")        if  sanankou?(tehai, agari)
        yaku_list << Yaku.find_by_name("sankantsu")       if  sankantsu?(tehai, agari)
        yaku_list << Yaku.find_by_name("shousangen")      if  shousangen?(tehai, agari)
        yaku_list << Yaku.find_by_name("doublereach")     if  doublereach?(tehai, agari)
        yaku_list << Yaku.find_by_name("chitoitsu")       if  chitoitsu?(tehai, agari)
		yaku_list << Yaku.find_by_name("sanshoku")        if  sanshoku?(tehai, agari)
        yaku_list << Yaku.find_by_name("sanshokudouko")   if  sanshokudouko?(tehai, agari)
		# 3～6ファン
        yaku_list << Yaku.find_by_name("honitsu")         if  honitsu?(tehai, agari)
		yaku_list << Yaku.find_by_name("honroutou")       if  honroutou?(tehai, agari)
        yaku_list << Yaku.find_by_name("junchan")         if  junchan?(tehai, agari)
        yaku_list << Yaku.find_by_name("ryanpeikou")      if  ryanpeikou?(tehai, agari)
        yaku_list << Yaku.find_by_name("chinitsu")        if  chinitsu?(tehai, agari)
		
        tehai.yaku_list = yaku_list
      end
    end
  end
end
