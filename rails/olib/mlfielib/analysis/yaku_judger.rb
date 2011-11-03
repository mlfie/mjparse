# -*- coding: utf-8 -*-
require 'mlfielib/analysis/yaku_specimen'
require 'mlfielib/analysis/yaku_judger_one'
require 'mlfielib/analysis/yaku_judger_two'
require 'mlfielib/analysis/yaku_judger_three_six'
require 'mlfielib/analysis/yaku_judger_man'
	
module Mlfielib
  module Analysis
    class YakuJudger
      
      ### 処理結果
      RESULT_SUCCESS          = 0     # 正常終了
      RESULT_ERROR_INTERNAL   = 9     # 不明な内部エラー

      attr_accessor :yaku_list,       # 役のリスト
                    :result_code,     # 処理結果
                    :yaku_specimen    # 役の標本(Hash形式)
      
      def initialize(_yaku_specimen)
        self.yaku_list      = Array.new
        self.result_code    = RESULT_SUCCESS
        self.yaku_specimen  = _yaku_specimen
      end

      def set_yaku_list(tehai, kyoku)
#*****************************************************************#
# 役満の判定を行う
#*****************************************************************#
        self.yaku_list << self.yaku_specimen["daisangen"]       if  daisangen?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["kokushi"]         if  kokushi?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["suankou"]         if  suankou?(tehai, kyoku)		
		    self.yaku_list << self.yaku_specimen["sukantsu"]        if  sukantsu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["tenho"]           if  tenho?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["chiho"]           if  chiho?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["tasushi"]         if  tasushi?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["shosushi"]        if  shosushi?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["tsuiso"]          if  tsuiso?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["chinraoto"]       if  chinraoto?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["ryuiso"]          if  ryuiso?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["churen"]          if  churen?(tehai, kyoku)	
        # 役満は該当したらreturn
        if self.yaku_list.size > 0
          return
        end

#*****************************************************************#
# 一翻役の判定を行う
#*****************************************************************#
		    self.yaku_list << self.yaku_specimen["reach"]           if  reach?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["ippatsu"]         if  ippatsu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["tanyao"]          if  tanyao?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["pinfu"]           if  pinfu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["iipeikou"]        if  iipeikou?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["tsumo"]           if  tsumo?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["haku"]            if  haku?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["hatsu"]           if  hatsu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["chun"]            if  chun?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["ton"]             if  ton?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["nan"]             if  nan?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["sha"]             if  sha?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["pei"]             if  pei?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["rinshan"]         if  rinshan?(tehai, kyoku)
		    self.yaku_list << self.yaku_specimen["chankan"]         if  chankan?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["haitei"]          if  haitei?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["houtei"]          if  houtei?(tehai, kyoku)

#*****************************************************************#
# 二翻役の判定を行う
#*****************************************************************#
        self.yaku_list << self.yaku_specimen["ikkitsukan"]      if  ikkitsukan?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["chanta"]          if  chanta?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["toitoihou"]       if  toitoihou?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["sanankou"]        if  sanankou?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["sankantsu"]       if  sankantsu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["shousangen"]      if  shousangen?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["doublereach"]     if  doublereach?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["chitoitsu"]       if  chitoitsu?(tehai, kyoku)
		    self.yaku_list << self.yaku_specimen["sanshoku"]        if  sanshoku?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["sanshokudouko"]   if  sanshokudouko?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["honroutou"]       if  honroutou?(tehai, kyoku)

#*****************************************************************#
# 三翻役の判定を行う
#*****************************************************************#
        self.yaku_list << self.yaku_specimen["honitsu"]         if  honitsu?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["junchan"]         if  junchan?(tehai, kyoku)
        self.yaku_list << self.yaku_specimen["ryanpeikou"]      if  ryanpeikou?(tehai, kyoku)

#*****************************************************************#
# 六翻役の判定を行う
#*****************************************************************#
        self.yaku_list << self.yaku_specimen["chinitsu"]        if  chinitsu?(tehai, kyoku)
      end
    end
  end
end
