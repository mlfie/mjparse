require 'test/unit'
require 'test_helper'
require 'mlfielib/cv/template_matcher'
require 'opencv'
require 'cv_test_helper'

class TemplateMatcherTest < Test::Unit::TestCase
  include CvTestHelper
  include OpenCV

  TEST_IMG_PATH="olib_test/unit/mlfielib/cv/test_img/"

  def setup
    @@mode = :debug
    @template_path = TEST_IMG_PATH + "template_matcher_test_template.jpg"
    @target_path= TEST_IMG_PATH + "template_matcher_test_target.jpg"

    @template_image = IplImage.load(
      @template_path,
      CV_LOAD_IMAGE_GRAYSCALE
    )
    @default_matcher = Mlfielib::CV::TemplateMatcher.new(
      @template_path
    )
    @matcher = Mlfielib::CV::TemplateMatcher.new(
      @template_path,
      :threshold => 0.7,
      :algorithm => :normed
    )
  end

  def test_template_path
    assert_equal @template_path, @matcher.template_path
  end

  def test_default_threshold
    assert_equal Mlfielib::CV::TemplateMatcher::DEFAULT_THRESHOLD, @default_matcher.threshold
  end

  def test_threshold
    assert_equal 0.7, @matcher.threshold
    @matcher.threshold = 0.1
    assert_equal 0.1, @matcher.threshold
  end

  def test_default_algorithm
    assert_equal Mlfielib::CV::TemplateMatcher::DEFAULT_ALGORITHM, @default_matcher.algorithm
  end

  def test_algorithm
    assert_equal :normed, @matcher.algorithm
    @matcher.algorithm = :ccoeff
    assert_equal :ccoeff, @matcher.algorithm
  end

  def test_detect
    @matcher.algorithm = :ccoeff_normed
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
