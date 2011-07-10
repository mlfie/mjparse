require 'mlfielib/geom/point'
require 'mlfielib/geom/point_op'
require 'mlfielib/geom/rect_op'

module Mlfielib
  module CV
    class Pai
      include Mlfielib::Geom::PointOp
      include Mlfielib::Geom::RectOp
        def initialize(x=0, y=0, width=0, height=0, value=0, type=nil, direction=:top)
         @x = x
         @y = y
         @width = width
         @height = height
         @value = value
         @type = type
         @direction = direction
        end
    
        attr_accessor :x, :y, :width, :height, :value, :type, :direction
  
        #TODO refactor
        def -(pai)
          Pai.new(x - pai.x, y - pai.y)
        end
        def position
          Mlfielib::Geom::Point.new(@x, @y)
        end
    end
  end
end
