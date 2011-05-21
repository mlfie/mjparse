require 'test/unit'
require 'test_helper'
require 'mlfielib/geom/rect'
require 'mlfielib/geom/rect_op'

include Mlfielib::Geom

class RectTest < Test::Unit::TestCase
  include Mlfielib::Geom::RectOp::Test

  def setup
    @model = Rect.new(Point.new(1,2), 5, 10)
    @r0 = Rect.new(Point.new, 10, 20)
  end

  def test_to_s 
    assert_equal "((0,0),10,20)", @r0.to_s
  end

  def test_attributes
    assert_equal Point.new, @r0.position
    assert_equal 10, @r0.width
    assert_equal 20, @r0.height
  end

  def test_equals
    other = Rect.new(Point.new, 10, 20)
    assert @r0 == other
  end

end
