# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'yaku_specimen')
require File.join(File.dirname(__FILE__), 'yaku_judger_one.rb')
require File.join(File.dirname(__FILE__), 'yaku_judger_two.rb')
require File.join(File.dirname(__FILE__), 'yaku_judger_three_six.rb')
require File.join(File.dirname(__FILE__), 'yaku_judger_man.rb')
	
module Mjparse
  class YakuJudger
    include YakuJudgerOne
    include YakuJudgerTwo
    include YakuJudgerThreeSix
    include YakuJudgerMan
    
    ### 処理結果
    RESULT_SUCCESS          = 0     # 正常終了
    RESULT_ERROR_YAKUNASHI  = 1     # 役無しの場合
    RESULT_ERROR_INTERNAL   = 9     # 不明な内部エラー

    attr_accessor :yaku_list,       # 役のリスト
                  :result_code,     # 処理結果
                  :yaku_specimen    # 役の標本(Hash形式)
    
    # 初期化メソッド
    def initialize(yaku_specimen)
      self.yaku_list      = Array.new
      self.result_code    = RESULT_SUCCESS
      self.yaku_specimen  = yaku_specimen
    end

    # 成立している役の判定を行う。
    def set_yaku_list(tehai, kyoku)
#*****************************************************************#
# 役満の判定を行う
#*****************************************************************#
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_DAISANGEN]       if  daisangen?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_KOKUSHI]         if  kokushi?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SUANKOU]         if  suankou?(tehai, kyoku)		
	    self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SUKANTSU]        if  sukantsu?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TENHO]           if  tenho?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHIHO]           if  chiho?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TASUSHI]         if  tasushi?(tehai, kyoku)
      # 小四喜は大四喜の下位役のため
      if self.yaku_list.index(self.yaku_specimen[YakuSpecimen::YAKU_NAME_TASUSHI]) == nil && shosushi?(tehai, kyoku) then
        self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SHOSUSHI]
      end
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TSUISO]          if  tsuiso?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHINRAOTO]       if  chinraoto?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_RYUISO]          if  ryuiso?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHUREN]          if  churen?(tehai, kyoku)	

      # 応急処置. リスト中のnilを削除. TODO Fix it!
      self.yaku_list = self.yaku_list.select {|e| !e.nil?}

      # 役満が1つでも該当した場合は、通常の役判定は行わない.
      if self.yaku_list.size > 0 then
        return
      end

#*****************************************************************#
# 六翻役の判定を行う
#*****************************************************************#
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHINITSU]        if  chinitsu?(tehai, kyoku)

#*****************************************************************#
# 三翻役の判定を行う
#*****************************************************************#
      # 混一色は清一色の下位役
      if self.yaku_list.index(self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHINITSU]) == nil && honitsu?(tehai, kyoku) then
        self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HONITSU]
      end
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_JUNCHAN]         if  junchan?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_RYANPEIKOU]      if  ryanpeikou?(tehai, kyoku)

#*****************************************************************#
# 二翻役の判定を行う
#*****************************************************************#
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_IKKITSUKAN]      if  ikkitsukan?(tehai, kyoku)
      # 混全帯么九は純全帯么九の下位役のため
      if self.yaku_list.index(self.yaku_specimen[YakuSpecimen::YAKU_NAME_JUNCHAN]) == nil && chanta?(tehai, kyoku) then
        self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHANTA]
      end
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TOITOIHOU]       if  toitoihou?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SANANKOU]        if  sanankou?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SANKANTSU]       if  sankantsu?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SHOUSANGEN]      if  shousangen?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_DOUBLEREACH]     if  doublereach?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHITOITSU]       if  chitoitsu?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SANSHOKU]        if  sanshoku?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_SANSHOKUDOUKO]   if  sanshokudouko?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HONROUTOU]       if  honroutou?(tehai, kyoku)

#*****************************************************************#
# 一翻役の判定を行う
#*****************************************************************#
      # 立直はダブル立直の下位役のため
      if self.yaku_list.index(self.yaku_specimen[YakuSpecimen::YAKU_NAME_DOUBLEREACH]) == nil && reach?(tehai, kyoku) then
		    self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_REACH]
      end
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_IPPATSU]         if  ippatsu?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TANYAO]          if  tanyao?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_PINFU]           if  pinfu?(tehai, kyoku)
      # 一盃口は二盃口の下位役のため
      if self.yaku_list.index(self.yaku_specimen[YakuSpecimen::YAKU_NAME_RYANPEIKOU]) == nil && iipeikou?(tehai, kyoku) then
        self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_IIPEIKOU]
      end
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_TSUMO]           if  tsumo?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HAKU]            if  haku?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HATSU]           if  hatsu?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHUN]            if  chun?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_JIKAZETON]       if  jikazeton?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_JIKAZENAN]       if  jikazenan?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_JIKAZESHA]       if  jikazesha?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_JIKAZEPEI]       if  jikazepei?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_BAKAZETON]       if  bakazeton?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_BAKAZENAN]       if  bakazenan?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_BAKAZESHA]       if  bakazesha?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_BAKAZEPEI]       if  bakazepei?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_RINSHAN]         if  rinshan?(tehai, kyoku)
	    self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_CHANKAN]         if  chankan?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HAITEI]          if  haitei?(tehai, kyoku)
      self.yaku_list << self.yaku_specimen[YakuSpecimen::YAKU_NAME_HOUTEI]          if  houtei?(tehai, kyoku)

      # 応急処置. リスト中のnilを削除. TODO Fix it!
      self.yaku_list = self.yaku_list.select {|e| !e.nil?}

      # 役の判定結果を返す
      if self.yaku_list.size < 1 then
        self.result_code = RESULT_ERROR_YAKUNASHI
      end
    end
  end
end
