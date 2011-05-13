require 'test_helper'
require 'fitting/least_median_squares_line_fitting'
require 'fitting/line_fitting'
require 'cv/template_matching_analyzer'
require 'cv/filter'
require 'cv/selector'
require 'cv/pai'

class TemplateMatchingAnalyzerTest < ActiveSupport::TestCase
  def setup
    @tma = TemplateMatchingAnalyzer.new
  end


  test "analyze" do
    assert @tma.analyze
  end
end
