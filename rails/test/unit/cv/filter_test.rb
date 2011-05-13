require 'test_helper'
require 'fitting/least_median_squares_line_fitting'
require 'fitting/line_fitting'
require 'cv/filter'
require 'cv/pai'

class FilterTest < ActiveSupport::TestCase
  def setup
    @pais = []

    14.times{|i|
      @pais << CV::Pai.new(i, 3*i, 1, 1)
    }
    12.times{
      @pais << CV::Pai.new(rand(20), rand(20),1,1)
    }
    @filter = CV::Filter.new
  end


  test "filter" do
    filtered_pais = @filter.filter(@pais)
    filtered_pais.each do |pai|
      assert_in_delta 3*pai.x, pai.y, 1
    end
  end
end
