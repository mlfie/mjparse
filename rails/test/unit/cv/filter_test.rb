require 'test_helper'
require 'fitting/least_median_squares_line_fitting'
require 'fitting/line_fitting'
require 'cv/filter'
require 'cv/pai'

class FilterTest < ActiveSupport::TestCase
  def setup
    @pais = []

    14.times{|i|
      @pais << CV::Pai.new(i, 3*i)
    }
    12.times{
      @pais << CV::Pai.new(rand(20), rand(20))
    }
    @filter = CV::Filter.new
  end


  test "filter" do
    assert @filter.filter(@pais)
  end
end
