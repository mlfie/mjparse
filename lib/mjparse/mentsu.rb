# -*- coding: utf-8 -*-

module Mjparse
  class Mentsu
    # 面子の種類
    MENTSU_TYPE_SHUNTSU = 's'   # 順子系面子(順子, チー)
    MENTSU_TYPE_KOUTSU  = 'k'   # 刻子系面子(刻子、ポン)
    MENTSU_TYPE_KANTSU  = '4'   # 槓子系面子(暗槓、明槓)
    MENTSU_TYPE_TOITSU  = 't'   # 対子系面子(対子)
    MENTSU_TYPE_TOKUSYU = 'y'   # 特殊系面子(国士無双、十三不塔)

    attr_accessor :pai_list,    # 牌(Paiクラス)のリスト
                  :mentsu_type, # 面子の種類(s:順子, k:刻子, 4:槓子, t:対子, y:特殊形)
                  :furo         # 副露面子かどうか(true:副露, false:門前)
    
    # 初期化メソッド
    def initialize(pai_list, mentsu_type, furo)
      self.pai_list     = pai_list
      self.mentsu_type  = mentsu_type
      self.furo         = furo
    end
  
    # 順子かどうか
    def shuntsu?
      self.mentsu_type == MENTSU_TYPE_SHUNTSU
    end
  
    # 刻子かどうか
    def koutsu?
      self.mentsu_type == MENTSU_TYPE_KOUTSU
    end
    
    # 槓子かどうか
    def kantsu?
      self.mentsu_type == MENTSU_TYPE_KANTSU
    end
    
    # 対子かどうか
    def toitsu?
      self.mentsu_type == MENTSU_TYPE_TOITSU
    end
  
    # 特殊系かどうか
    def tokusyu?
      self.mentsu_type == MENTSU_TYPE_TOKUSYU
    end
    
    # 副露かどうか
    def furo?
      self.pai_list.any?{|pai| pai.naki}
    end
      
    # 全ての牌が萬子か？
    def manzu?
      self.pai_list.all?{|pai| pai.manzu? }
    end

    # 全ての牌が筒子か？
    def pinzu?
      self.pai_list.all?{|pai| pai.pinzu? }
    end

    # 全ての牌が索子か？
    def souzu?
      self.pai_list.all?{|pai| pai.souzu? }
    end

    # 全ての牌が字牌か？
    def jihai?
      self.pai_list.all?{|pai| pai.jihai? }
    end

    # ヤオチュウ牌が含まれるか？
    def yaochu?
      self.pai_list.any?{|pai| pai.yaochu? }
    end
    
    # 両面待ちでのアガリ面子であるか？
    def ryanmen?
      if self.shuntsu?
        if self.pai_list[0].agari || self.pai_list[2].agari
          if ( self.pai_list[0].agari && self.pai_list[2].number!=9 ) ||
             ( self.pai_list[2].agari && self.pai_list[0].number!=1 )
            return true
          end
        end
      end
      return false
    end
    
    # 辺張待ちでのアガリ面子であるか？
    def penchan?
      if self.shuntsu?
        if ( self.pai_list[0].agari && self.pai_list[2].number==9 ) ||
           ( self.pai_list[2].agari && self.pai_list[0].number==1 )
          return true
        end
      end
      return false
    end
    
    # 嵌張待ちでのアガリ面子であるか？
    def kanchan?
      if self.shuntsu?
        if self.pai_list[1].agari
          return true
        end
      end
      return false
    end
    
    # 単騎待ちでのアガリ面子であるか？
    def tanki?
      if self.toitsu?
        if self.pai_list[0].agari && self.pai_list[1].agari
          return true
        end
      end
      return false
    end
    
    # 双ポン待ちでのアガリ面子であるか？
    def shanpon?
      if self.koutsu?
        if self.pai_list[0].agari || self.pai_list[1].agari || self.pai_list[2].agari then
          return true
        end
      end
      return false
    end

  end
end
