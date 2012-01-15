# -*- coding: utf-8 -*-

module Mjparse
  class Tehai
    attr_accessor :mentsu_list,   # 面子(Mentsu)のリスト(リストの数 通常:4 七対子:6 国士無双:1 )
                  :atama,         # 雀頭(Paiが1つ)
                  :furo,          # 副露してるかどうか(してる場合はtrue)
                  :yaku_list,     # 役(YakuSpecimen)のリスト
                  :fu_num,        # 符数
                  :han_num,       # 飜数
                  :mangan_scale,  # 満貫の倍数(0:なし 1:満貫 1.5:跳萬 2:倍萬 3:３倍萬 4:役萬 8:ダブル役萬)
                  :total_point,   # 総合得点
                  :parent_point,  # ツモアガリの際に親が払う点数
                  :child_point,   # ツモアガリの際に子が払う点数
                  :ron_point      # ロンアガリの際に放銃した人が払う点数
                  
    def initialize(mentsu_list, atama, furo)
      self.mentsu_list = mentsu_list
      self.atama = atama
      self.furo = furo
      self.yaku_list = Array.new
      self.fu_num = 0
      self.han_num = 0
      self.mangan_scale = 0
      self.total_point = 0
      self.parent_point = 0
      self.child_point = 0
      self.ron_point = 0
    end

    def naki?
      self.mentsu_list.any? {|mentsu| mentsu.furo? }
    end

    def shuntsu_list
      self.mentsu_list.select {|mentsu| mentsu.shuntsu? }
    end

    def koutsu_list
      self.mentsu_list.select {|mentsu| mentsu.koutsu? }
    end

    def kantsu_list
      self.mentsu_list.select {|mentsu| mentsu.kantsu? }
    end
    
    # 手牌が両面アガリかどうかを判定
    def ryanmen_agari?
      self.mentsu_list.each do |mentsu|
        if mentsu.ryanmen? then
          return true
        end
      end
      return false
    end
    
    # 手牌が辺張アガリかどうかを判定
    def penchan_agari?
      self.mentsu_list.each do |mentsu|
        if mentsu.penchan? then
          return true
        end
      end
      return false
    end

    # 手牌が嵌張アガリかどうかを判定
    def kanchan_agari?
      self.mentsu_list.each do |mentsu|
        if mentsu.kanchan? then
          return true
        end
      end
      return false
    end
    
    # 手牌が双ポンアガリかどうかを判定
    def shanpon_agari?
      self.mentsu_list.each do |mentsu|
        if mentsu.shanpon? then
          return true
        end
      end
      return false
    end
    
    # 手牌が単騎アガリかどうかを判定
    def tanki_agari?
      if self.atama.agari then
        return true
      end
      return false
    end

    def tokusyu?
      self.mentsu_list.any?{|mentsu| mentsu.tokusyu?}
    end
    
  end
end
