module Mlfielib
  module Geom
    class Point
      attr_accessor :x, :y

      def initialize(x = 0, y = 0)
        @x, @y = x, y
      end

      def to_s
        "(#@x,#@y)"
      end

      #Operators
      def +(other)
        Point.new(@x + other.x, @y + other.y)
      end

      def -(other)
        Point.new(@x - other.x, @y - other.y)
      end

      def -@
        Point.new(-@x, -@y)
      end

      def *(scalar)
        Point.new(@x * scalar, @y * scalar)
      end

      def coerce(scalar)
        [self, scalar]
      end

      def ==(other)
        if other.is_a? Point
          @x==other.x && @y==other.y
        else
          false
        end
      end
    end
  end
end
