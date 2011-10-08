require 'mlfielib/cv/template_matching_classifier'
require 'mlfielib/cv/filter'
require 'mlfielib/cv/selector'
require 'opencv'
include OpenCV

module Mlfielib
  module CV
    class TemplateMatchingAnalyzer
      def initialize
        @debug = false
      end
  
      def analyze(img_path)
        pais = analyze_raw(img_path)
        pais.map {|e| e.type}.join
      end
  
      def analyze_raw(img_path)
        path = img_path #"lib/cv/test_img/test004.jpg" 
        tmc = CV::TemplateMatchingClassifier.new

        pais_candidate = []
        pais_candidate << tmc.classify(path)
        pais_candidate << tmc.classify(path, 0.9)
        pais_candidate << tmc.classify(path, 0.8)
        pais = pais_candidate.max_by{|p| p.size}
  
        debug path, pais if @debug
  
        filter = CV::Filter.new
        filtered_pais = filter.filter(pais)
  
        debug_line path, filter.origin, filter.vector, pais if @debug
  
        selector = CV::Selector.new
        selected_pais = selector.select(filtered_pais)
        selected_pais.sort{|a,b| a.x-b.x}
      end
  
      def debug_line(path, origin, vector, pais)
        win = GUI::Window.new "debug_line"
        img = IplImage.load(path, CV_LOAD_IMAGE_COLOR)
        pais.each do |pai|
          img.rectangle!(CvPoint.new(pai.left, pai.top), CvPoint.new(pai.right, pai.bottom), :color=>CvColor::Black, :thickness =>2)
        end
        img.line!(CvPoint.new(origin.x, origin.y), CvPoint.new(img.width * vector.x + origin.x, img.width * vector.y + origin.y), :color=>CvColor::Red, :thickness => 3)
        win.show img
        GUI::wait_key
      end
  
      def debug(path, pais)
        win = GUI::Window.new "debug"
        img = IplImage.load(path, CV_LOAD_IMAGE_GRAYSCALE)
        pais.each do |pai|
          img.rectangle!(CvPoint.new(pai.left, pai.top), CvPoint.new(pai.right, pai.bottom), :color=>CvColor::Red, :thickness => 3)
        end
        win.show img
        GUI::wait_key
      end
    end
  end
end
