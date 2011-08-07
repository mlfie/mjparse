require 'mlfielib/geom/point'
require 'mlfielib/geom/rect_op'

module Mlfielib
  module Geom
    class Rect
      include Mlfielib::Geom::RectOp

      attr_accessor :x, :y, :position, :width, :height

      def initialize(x=0, y=0, width=0, height=0)
        @position = Mlfielib::Geom::Point.new(x, y)
        @width, @height = width, height
      end

      def x
        @position.x
      end
      def x=(val)
        @position.x = val
      end
      def y
        @position.y
      end
      def y=(val)
        @position.y = val
      end

      def to_s
        "(#@position,#@width,#@height)"
      end

      #Operators
      def ==(other)
        if other.is_a? Rect
          @position == other.position &&
            @width == other.width &&
            @height == other.height
        else
          false
        end
      end
    end
  end
end
