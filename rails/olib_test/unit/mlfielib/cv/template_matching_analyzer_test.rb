require 'test/unit'
require 'test_helper'
require 'mlfielib/fitting/least_median_squares_line_fitting'
require 'mlfielib/fitting/line_fitting'
require 'mlfielib/cv/template_matching_analyzer'
require 'mlfielib/cv/filter'
require 'mlfielib/cv/selector'
require 'mlfielib/cv/pai'
require 'rubygems'
require 'opencv'
require 'cv_test_helper'

include OpenCV
class TemplateMatchingAnalyzerTest < Test::Unit::TestCase
  include CvTestHelper
  def setup
    #for debug mode, uncomment below
    @@mode = :debug
    @tma = Mlfielib::CV::TemplateMatchingAnalyzer.new
  end

  def test_analyze
    #path = "olib_test/unit/mlfielib/cv/test_img/59.jpg"
    path = "olib_test/unit/mlfielib/cv/test_img/73.jpg"
    expects = %w[m3 m3 m3 j6 j6 j6 j2 j2 p3 p5 m7 m8 m9 p4]

    pais = @tma.analyze_raw(path)
    debug {
      img = IplImage.load(path, CV_LOAD_IMAGE_GRAYSCALE)
      win = GUI::Window.new "debug result"
      pais.each do |pai|
        puts "#{pai.type}, #{pai.x}, #{pai.y}, #{pai.value}, #{pai.direction}"
        img.rectangle!(CvPoint.new(pai.left, pai.top), CvPoint.new(pai.right,pai.bottom), :color=>CvColor::Red, :thickness => 3)
      win.show img
      GUI::wait_key
      end
    }
    expects.zip(pais).each do |expect, pai|
      assert_equal expect, pai.type.to_s
    end
  end
end
