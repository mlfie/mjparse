require 'test/unit'
require 'mlfielib/geom/point'

include Mlfielib::Geom

class PointTest < Test::Unit::TestCase
  def setup
    @p0 = Point.new
    @p1 = Point.new(3.0, 4.0)
    @p2 = Point.new(4.0, -3.0)
  end

  def test_to_s 
    assert_equal "(0,0)", @p0.to_s
    assert_equal "(3.0,4.0)", @p1.to_s
    assert_equal "(4.0,-3.0)", @p2.to_s
  end

  def test_plus
    assert_equal Point.new(3, 4), @p0+@p1
    assert_equal Point.new(7, 1), @p1+@p2
  end

  def test_minus
    assert_equal Point.new(-3, -4), @p0-@p1
    assert_equal Point.new(-1, 7), @p1-@p2
    assert_equal Point.new(-3, -4), -@p1
  end
  def test_muliply
    assert_equal Point.new(0, 0), @p0 * 3
    assert_equal Point.new(9, 12), @p1 * 3
    assert_equal Point.new(9, 12), 3 * @p1
  end
end
