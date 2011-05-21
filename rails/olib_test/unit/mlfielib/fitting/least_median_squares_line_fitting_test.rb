require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/least_median_squares_line_fitting'
require 'mlfielib/fitting/line_fitting'

class LeastMedianSquaresLineFittingTest < Test::Unit::TestCase
  def setup
    @points = []

    11.times{|i|
      @points << Mlfielib::Geom::Point.new(i, 3 * i)
    }
    10.times{
      @points << Mlfielib::Geom::Point.new(rand(20), rand(20))
    }
    @fitting = Mlfielib::Fitting::LeastMedianSquaresParamSearch.new(
      Mlfielib::Fitting::LMSLineFittingModel.new(@points), 0.5, 20000)
  end


  def test_points_and_add
    intercept, slope = @fitting.search
    assert_in_delta 3.0, slope, 0.1
    assert_in_delta 0.0, intercept, 0.1
  end
end
