# -*- coding: utf-8 -*-
module Mjt
 module Analysis
  class Pai
    attr_accessor :type,    # 牌の種類(m:萬子 s:索子 p:筒子 j:字牌)
                  :number,  # 数字(字牌の場合、1:東 2:南 3:西 4:北 5:白 6:發 7:中)
                  :agari

    def initialize(tehai_st, agari)
      self.type     = tehai_st[0, 1]
      self.number   = tehai_st[1, 1].to_i
      self.agari = agari
    end
    
    def ==(pai)
      if self.type == pai.type && self.number == pai.number
        return true
      end
      return false
    end

    def yaochu?
      return self.number == 1 || self.number == 9 || self.type == "j"
    end
    
    def chuchan?
      return ! yaochu?
    end
  end   
 end
end
