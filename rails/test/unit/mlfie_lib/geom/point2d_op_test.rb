require 'test_helper'
require 'mlfielib/geom/point2d_op'

class Point2DOpTest < ActiveSupport::TestCase
  class Point
    include Mlfielib::Geom::Point2DOp
    attr_accessor :x, :y;
    def initialize(x = 0.0, y = 0.0)
      @x = x
      @y = y
    end
    def minus(p)
      Point.new(x-p.x, y-p.y)
    end
  end
  class Rect
    include Mlfielib::Geom::RectOp
    attr_accessor :x, :y, :width, :height
    def initialize(x=0,y=0,width=0,height=0)
      @x=x
      @y=y
      @width=width
      @height=height
    end
  end

  def setup
    @p0 = Point.new
    @p1 = Point.new(3.0, 4.0)
    @p2 = Point.new(4.0, -3.0)
  end

  test "distance" do
    assert_equal 5, @p0.distance(@p1)
  end

  test "intersection_angle" do
    assert_equal -25, @p1.cross_product(@p2)
    assert_equal 0, @p1.dot_product(@p2)
    assert_equal -Math::PI/2, @p1.intersection_angle(@p2)
  end

  test "distance_from_line" do
    origin = Point.new(0, 3)
    dir = Point.new(1,0)
    assert_equal 1, @p1.distance_from_line(origin, dir)
  end

  test "intersect" do
    r1 = Rect.new(3, 3, 4, 4)
    r2 = Rect.new(5, 5, 6, 6)

    assert r1.intersect?(r2)
    assert_equal 4, r1.intersect_area(r2)
  end

end
