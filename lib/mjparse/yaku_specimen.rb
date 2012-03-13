# -*- coding: utf-8 -*-

module Mjparse
  class YakuSpecimen
  
    # 一翻の役名
    YAKU_NAME_REACH           = "reach"
    YAKU_NAME_IPPATSU         = "ippatsu"
    YAKU_NAME_TANYAO          = "tanyao"
    YAKU_NAME_PINFU           = "pinfu"
    YAKU_NAME_IIPEIKOU        = "iipeikou"
    YAKU_NAME_TSUMO           = "tsumo"
    YAKU_NAME_HAKU            = "haku"
    YAKU_NAME_HATSU           = "hatsu"
    YAKU_NAME_CHUN            = "chun"
    YAKU_NAME_JIKAZETON       = "jikazeton"
    YAKU_NAME_JIKAZENAN       = "jikazenan"
    YAKU_NAME_JIKAZESHA       = "jikazesha"
    YAKU_NAME_JIKAZEPEI       = "jikazepei"
    YAKU_NAME_BAKAZETON       = "bakazeton"
    YAKU_NAME_BAKAZENAN       = "bakazenan"
    YAKU_NAME_BAKAZESHA       = "bakazesha"
    YAKU_NAME_BAKAZEPEI       = "bakazepei"
    YAKU_NAME_RINSHAN         = "rinshan"
    YAKU_NAME_CHANKAN         = "chankan"
    YAKU_NAME_HAITEI          = "haitei"
    YAKU_NAME_HOUTEI          = "houtei"
    # 二翻の役名
    YAKU_NAME_CHANTA          = "chanta"
    YAKU_NAME_TOITOIHOU       = "toitoihou"
    YAKU_NAME_SANANKOU        = "sanankou"
    YAKU_NAME_SANKANTSU       = "sankantsu"
    YAKU_NAME_SHOUSANGEN      = "shousangen"
    YAKU_NAME_DOUBLEREACH     = "doublereach"
    YAKU_NAME_CHITOITSU       = "chitoitsu"
    YAKU_NAME_SANSHOKU        = "sanshoku"
    YAKU_NAME_SANSHOKUDOUKOU  = "sanshokudouko"
    YAKU_NAME_HONROUTOU       = "honroutou"      
    # 三翻の役名
    YAKU_NAME_HONITSU         = "honitsu"
    YAKU_NAME_JUNCHAN         = "junchan"
    YAKU_NAME_RYANPEIKOU      = "ryanpeikou"      
    # 六翻の役名
    YAKU_NAME_CHINITSU        = "chinitsu"
    # 役満の役名
    YAKU_NAME_DAISANGEN       = "daisangen"
    YAKU_NAME_KOKUSHI         = "kokushi"
    YAKU_NAME_SUANKOU         = "suankou"
    YAKU_NAME_SUKANTSU        = "sukantsu"
    YAKU_NAME_TENHO           = "tenho"
    YAKU_NAME_CHIHO           = "chiho"
    YAKU_NAME_TASUSHI         = "tasushi"
    YAKU_NAME_SHOSUSHI        = "shosushi"
    YAKU_NAME_TSUISO          = "tsuiso"
    YAKU_NAME_CHINRAOTO       = "chinraoto"
    YAKU_NAME_RYUISO          = "ryuiso"
    YAKU_NAME_CHUREN          = "churen"    
  
    attr_accessor :name,          # 役名
                  :kanji,         # 漢字表記名
                  :han_num,       # 門前での翻数
                  :naki_han_num   # 食い下がりした場合の翻数

    def initialize(_name=nil, _kanji=nil, _han_num=0, _naki_han_num=0)
      self.name = _name
      self.kanji = _kanji
      self.han_num = _han_num
      self.naki_han_num = _naki_han_num
    end

    # 比較用メソッドをオーバーライド
    def ==(specimen) 
      if specimen != nil then
        if self.name == specimen.name && self.han_num == specimen.han_num && self.naki_han_num == specimen.naki_han_num then 
          return true
        end
      end
      return false
    end
  end
end
