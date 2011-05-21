require 'mlfielib/geom/point'
require 'mlfielib/geom/rect_op'

module Mlfielib
  module Geom
    class Rect
      include Mlfielib::Geom::RectOp

      attr_accessor :position, :width, :height

      def initialize(position, width, height)
        @position, @width, @height = position, width, height
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
