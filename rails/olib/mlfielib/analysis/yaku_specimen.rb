# -*- coding: utf-8 -*-

module Mlfielib
 module Analysis
  class YakuSpecimen
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

  end
 end
end

