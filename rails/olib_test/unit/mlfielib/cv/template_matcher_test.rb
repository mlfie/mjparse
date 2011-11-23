require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/least_median_squares_line_fitting'
require 'mlfielib/fitting/line_fitting'
require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/cv/template_matching'
require 'mlfielib/cv/filter'
require 'mlfielib/cv/selector'
require 'mlfielib/cv/pai'
require 'rubygems'
require 'opencv'
require 'cv_test_helper'

include OpenCV
class TemplateMatcherTest < Test::Unit::TestCase
  include CvTestHelper
  include Mlfielib::CV
  include Mlfielib::CV::TemplateMatching

  def setup
    @path = File.expand_path('../../../../../olib/mlfielib/cv/base', __FILE__)
    @test_path = File.expand_path('../test_img', __FILE__)
    @matcher = TemplateMatcher.new(
      :type => PaiEnum.type_e::J7,
      :image_paths => ["#{@path}/j7.t.jpg"],
      :symmetric => false
    )
    $__debug_window ||= GUI::Window.new "TemplateMatcher DEBUG"

    #for debug mode, uncomment below
    @matcher.instance_eval { @debug = true }
  end

  def test_attributes
    assert_equal PaiEnum.type_e::J7, @matcher.type
    assert_equal :top, @matcher.direction
    assert_equal false, @matcher.symmetric?
  end

  def test_detect
    pais = @matcher.detect(CvMat.load("#{@test_path}/8.jpg", CV_LOAD_IMAGE_GRAYSCALE))
    assert_equal 3, pais.size
  end
end
