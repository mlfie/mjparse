require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/least_median_squares_line_fitting'
require 'mlfielib/fitting/line_fitting'
require 'mlfielib/cv/filter'
require 'mlfielib/cv/selector'
require 'mlfielib/cv/pai'

class FilterTest < Test::Unit::TestCase
  def setup
    @pais = []

    14.times{|i|
      @pais << Mlfielib::CV::Pai.new(i, 3*i, 1, 1)
    }
    12.times{
      @pais << Mlfielib::CV::Pai.new(rand(20), rand(20),1,1)
    }
    @filter = Mlfielib::CV::Filter.new
  end


  def test_filter
    filtered_pais = @filter.filter(@pais)
    filtered_pais.each do |pai|
      assert_in_delta 3*pai.x, pai.y, 1
    end

    selector = Mlfielib::CV::Selector.new
    selector.select(filtered_pais)

  end
end
