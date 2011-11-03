# -*- coding: utf-8 -*-

module Mlfielib::Analysis
  class Tehai
    attr_accessor :mentsu_list,   # 面子(Mentsu)のリスト
                  :atama,         # 雀頭(1枚)
                  :yaku_list,     # 役(Yaku)のリスト
                  :fu_num,        # 符数
                  :han_num,       # 飜数
                  :mangan_scale,  # 満貫の倍数(0:なし 1:満貫 1.5:跳萬 2:倍萬 3:３倍萬 4:役萬 8:ダブル役萬)
                  :total_point,   # 総合得点
                  :parent_point,  # 親が払う点数
                  :child_point    # 子が払う点数
                  
    def initialize(mentsu_list, atama)
      self.mentsu_list = mentsu_list
      self.atama = atama
      self.yaku_list = Array.new
      self.fu_num = 0
      self.han_num = 0
      self.mangan_scale = 0
      self.total_point = 0
      self.parent_point = 0
      self.child_point = 0
    end
  end
end