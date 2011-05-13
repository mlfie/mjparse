module Mjt::Analysis
  class Pai
    attr_accessor :type,    # 牌の種類(m:萬子 s:索子 p:筒子 j:字牌)
                  :number,  # 数字(字牌の場合、1:東 2:南 3:西 4:北 5:白 6:發 7:中)
                  :is_agari # アガリ牌かどうか(true/false)

    def initialize(tehai_st, is_agari)
      @type     = tehai_st[0, 1]
      @number   = tehai_st[1, 1].to_i
      @is_agari = is_agari
    end

  end
end