require 'cv/template_matching_classifier'
require 'cv/filter'
require 'cv/selector'
require 'opencv'
include OpenCV

module CV
  class TemplateMatchingAnalyzer

    def analyze(img_path)
      pais = analyze_raw
      pais.map {|e| e.type}
    end

    def analyze_raw
      @debug = true
      path = "lib/cv/test_img/test004.jpg" 
      tmc = CV::TemplateMatchingClassifier.new
      pais = tmc.classify(path)

      debug path, pais if @debug

      filter = CV::Filter.new
      filtered_pais = filter.filter(pais)

      selector = CV::Selector.new
      selected_pais = selector.select(filtered_pais)
      selected_pais.sort{|a,b| a.x-b.x}
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
