require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/least_median_squares_line_fitting'
require 'mlfielib/fitting/line_fitting'
require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/cv/template_matching_classifier'
require 'mlfielib/cv/filter'
require 'mlfielib/cv/selector'
require 'mlfielib/cv/pai'
require 'rubygems'
require 'opencv'
require 'cv_test_helper'

include OpenCV
class TemplateMatchingClassifierTest < Test::Unit::TestCase
  include CvTestHelper
  include Mlfielib::CV

  def setup
    @path = File.expand_path('../../../../../olib/mlfielib/cv/base', __FILE__)
    @test_path = File.expand_path('../test_img', __FILE__)
    @classifier = TemplateMatchingClassifier.new()
  end

  def test_attributes
    assert true
  end
end
