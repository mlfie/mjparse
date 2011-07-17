require 'test/unit'
require 'test_helper'
require 'mlfielib/cv/template_matching'
require 'opencv'
require 'cv_test_helper'

class TemplateMatcherTest < Test::Unit::TestCase
  include CvTestHelper
  include OpenCV
  include Mlfielib::CV::TemplateMatching

  TEST_IMG_PATH="olib_test/unit/mlfielib/cv/test_img/"

  def setup
    @@mode = :debug
    @template_path = TEST_IMG_PATH + "template_matcher_test_template.jpg"
    @target_path= TEST_IMG_PATH + "template_matcher_test_target.jpg"

    @template_image = IplImage.load(
      @template_path,
      CV_LOAD_IMAGE_GRAYSCALE
    )
    @matcher = TemplateMatcher.new(
      CcoeffNormedModel.new(0.7),
      @template_path
    )
  end

  def test_template_path
    assert_equal @template_path, @matcher.template_path
  end

  def test_detect
    target = IplImage.load(@target_path, CV_LOAD_IMAGE_GRAYSCALE)
    detected_rects = @matcher.detect(@target_path)

    debug {
      window = GUI::Window.new "template matcher debug"
      detected_rects.each do |rect|
        target.rectangle!(CvPoint.new(rect.left, rect.top), CvPoint.new(rect.right, rect.bottom), :color => CvColor::Red, :thickness => 3)
        window.show target
        GUI::wait_key
      end
    }
  end
end
