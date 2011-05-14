module Mjt::Analysis
  class Mentsu
    attr_accessor :pai_list,    # 牌(Pai)のリスト
                  :mentsu_type  # 面子の種類(s:順子 k:刻子, t:対子, y:特殊形)
               
    def initialize
      self.pai_list = Array.new
    end
  end
end
    
