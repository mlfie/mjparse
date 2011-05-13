require 'mlfielib/geom/point2d_op'

module CV
  class Pai
    include Mlfielib::Geom::Point2DOp
      def initialize(x, y, width, height, value, type)
       @x = x
       @y = y
       @width = width
       @height = height
       @value = value
       @type = type
      end
  
      attr_accessor :x, :y, :width, :height, :value, :type
      
  end
end
