# -*- coding: utf-8 -*-

module Mjparse
  class Kyoku
    # 風牌の種類
    KYOKU_KAZE_TON          = 'ton';
    KYOKU_KAZE_NAN          = 'nan';
    KYOKU_KAZE_SHA          = 'sha';
    KYOKU_KAZE_PEI          = 'pei';
    KYOKU_KAZE_NONE         = 'none';
  
    attr_accessor :is_tsumo,      # ツモ(true)かロン(false)かを示す  false
                  :is_haitei,     # 海底摸月かどうかを示す            false
                  :dora_num,      # ドラ牌の枚数を示す               0               
                  :bakaze,        # 場風を示す                     'none'
                  :jikaze,        # 自風を示す                     'none'
                  :honba_num,     # 本場数を示す                    0
                  :is_rinshan,    # 嶺上開花かどうかを示す            false
                  :is_chankan,    # 槍槓かどうかを示す               false
                  :reach_num,     # 立直の種類を示す                 0
                  :is_ippatsu,    # 一発かどうかを示す               false
                  :is_tenho,      # 天和かどうかを示す               false
                  :is_chiho,      # 地和かどうかを示す               false
                  :is_parent      # 親(true)か子(false)かを示す     false

    def initialize
      self.is_tsumo   = false
      self.is_haitei  = false
      self.dora_num   = 0
      self.bakaze     = KYOKU_KAZE_NONE
      self.jikaze     = KYOKU_KAZE_NONE
      self.honba_num  = 0
      self.is_rinshan = false
      self.is_chankan = false
      self.reach_num  = 0
      self.is_ippatsu = false
      self.is_tenho   = false
      self.is_chiho   = false
      self.is_parent  = false

      #TODO refactor
      @kyoku_map = {
        KYOKU_KAZE_TON => 1,
        KYOKU_KAZE_NAN => 2,
        KYOKU_KAZE_SHA => 3,
        KYOKU_KAZE_PEI => 4,
        KYOKU_KAZE_NONE => -1,
      }
    end

    def reach?
      self.reach_num == 1
    end

    def doublereach?
      self.reach_num == 2
    end

    def jikaze?(pai)
      @kyoku_map[self.jikaze] == pai.number
    end

    def bakaze?(pai)
      @kyoku_map[self.bakaze] == pai.number
    end
  end
end

