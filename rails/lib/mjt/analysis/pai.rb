module Mjt::Analysis
  class Pai
    attr_accessor           :type, :number, :is_agari
#    validates_presence_of   :type, :number, :is_agari
#    validates_inclusion_of  :type,     :in => ['Manzu', 'Souzu', 'Pinzu', 'Jihai']
#    validates_inclusion_of  :number,   :in => [1, 2, 3, 4, 5, 6, 7, 8, 9]
#    validates_inclusion_of  :is_agari, :in => [true, false]

    def initialize(tehai_st, is_agari)
      @type = 'Manzu'
      @number = 1
      @is_agari = is_agari
    end

  end
end