require 'test_helper'
require 'fitting/least_median_squares_line_fitting'
require 'fitting/line_fitting'
require 'cv/template_matching_analyzer'
require 'cv/filter'
require 'cv/selector'
require 'cv/pai'
require 'rubygems'
require 'opencv'

include OpenCV
class TemplateMatchingAnalyzerTest < ActiveSupport::TestCase
  def setup
    @tma = CV::TemplateMatchingAnalyzer.new
  end

  test "analyze" do
    win = GUI::Window.new "result"
    path = "lib/cv/test_img/test004.jpg"
    img = IplImage.load(path, CV_LOAD_IMAGE_GRAYSCALE)
    pais = @tma.analyze_raw
    pais.each do |pai|
      puts "#{pai.type}, #{pai.x}, #{pai.y}, #{pai.value}"
      img.rectangle!(CvPoint.new(pai.left, pai.top), CvPoint.new(pai.right,pai.bottom), :color=>CvColor::Red, :thickness => 3)
    win.show img
    GUI::wait_key
    end
  end
end
