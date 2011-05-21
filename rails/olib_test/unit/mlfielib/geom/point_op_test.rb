require 'test/unit'
require 'test_helper'
require 'mlfielib/geom/point_op'

class Point2DOpTest < Test::Unit::TestCase
  class Point
    include Mlfielib::Geom::PointOp
    attr_accessor :x, :y;
    def initialize(x = 0.0, y = 0.0)
      @x = x
      @y = y
    end
    def -(p)
      Point.new(x-p.x, y-p.y)
    end
  end

  def setup
    @p0 = Point.new
    @p1 = Point.new(3.0, 4.0)
    @p2 = Point.new(4.0, -3.0)
  end

  def test_distance
    assert_equal 5, @p0.distance(@p1)
  end

  def test_intersection_angle
    assert_equal -25, @p1.cross_product(@p2)
    assert_equal 0, @p1.dot_product(@p2)
    assert_equal -Math::PI/2, @p1.intersection_angle(@p2)
  end

  def test_distance_from_line
    origin = Point.new(0, 3)
    dir = Point.new(1,0)
    assert_equal 1, @p1.distance_from_line(origin, dir)
  end
end
