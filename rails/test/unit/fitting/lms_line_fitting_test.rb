require 'test_helper'
require 'fitting/least_median_squares_line_fitting'
require 'fitting/line_fitting'

class LMSLineFittingTest < ActiveSupport::TestCase
  def setup
    @points = []

    11.times{|i|
      @points << Fitting::Point.new(i, 3 * i)
    }
    10.times{
      @points << Fitting::Point.new(rand(20), rand(20))
    }
    @fitting = Fitting::LeastMedianSquaresParamSearch.new(
      Fitting::LMSLineFittingModel.new(@points), 0.5, 20000)
  end


  test "points and add" do
    intercept, slope = @fitting.search
    assert_in_delta 3.0, slope, 0.1
    assert_in_delta 0.0, intercept, 0.1
  end
end
