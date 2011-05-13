require 'mlfielib/geom/point2d_op'

module CV
  class Pai
    include Mlfielib::Geom::Point2DOp
      def initialize(x=0, y=0, width=0, height=0, value=0, type=nil)
       @x = x
       @y = y
       @width = width
       @height = height
       @value = value
       @type = type
      end
  
      attr_accessor :x, :y, :width, :height, :value, :type

      #TODO refactor
      def minus(pai)
        Pai.new(x - pai.x, y - pai.y)
      end
      
  end
end
