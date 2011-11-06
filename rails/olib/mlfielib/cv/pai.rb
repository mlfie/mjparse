require 'mlfielib/geom/point'
require 'mlfielib/geom/rect'
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
         @rect = Mlfielib::Geom::Rect.new(x, y, width, height)
        end
    
        attr_accessor :x, :y, :width, :height, :value, :type, :direction
  
        def position
          @rect.position
        end
        def to_str
          return "#{@type}t" if @direction == :top
          return "#{@type}r"
        end
    end
  end
end
