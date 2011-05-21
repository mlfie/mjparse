require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/line_fitting'

class LineFittingTest < Test::Unit::TestCase
  def setup
    @fitting = Mlfielib::Fitting::LeastDistanceSquaresLineFitting.new
  end

  def test_points_and_add
    assert_equal [], @fitting.points
    p = Mlfielib::Geom::Point.new
    assert @fitting.add(p)
    assert_equal 1, @fitting.points.size
  end

  def test_fit_1
    self.fitting_with_no_error(1, 0)
  end

  def test_fit_2
    self.fitting_with_no_error(1.5, 3)
  end

  def test_fit_3
    self.fitting_with_no_error(-1.5, 3)
  end

  def test_fit_4
    self.fitting_with_no_error(1.5, -3)
  end

  def test_fit_5
    self.fitting_with_no_error(-1.5, -3)
  end

  def test_fit_6
    self.fitting_with_no_error(0, 3)
  end

  #test "fit -1.5 3 with error" do
  #  self.fitting_with_error(-1.5, 3)
  #end

  def fitting_with_no_error(slope, intercept)
    set_points(@fitting, slope, intercept)
    result = @fitting.fit
    assert_equal slope, result.slope
    assert_equal intercept, result.intercept
  end

  def fitting_with_error(slope, intercept)
    set_points_with_error(@fitting, slope, intercept, 1)
    result = @fitting.fit
    assert_equal slope, result.slope
    assert_equal intercept, result.intercept
  end

  def set_points(fitting, slope, intercept, num = 20)
    num.times{|i|
      fitting.add(Mlfielib::Geom::Point.new(i, i*slope + intercept))
    }
  end

  def set_points_with_error(fitting, slope, intercept, scale = 1, num = 20)
    num.times{|i|
      fitting.add(Mlfielib::Geom::Point.new(
        i + error(scale),
        i*slope + intercept + error(scale)))
    }
  end

  def error(scale)
    2.0 * scale * rand - scale
  end
end
