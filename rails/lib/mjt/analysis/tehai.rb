module Mjt::Analysis
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
    end
  end
end