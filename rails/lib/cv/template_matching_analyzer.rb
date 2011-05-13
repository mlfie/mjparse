require 'cv/template_matching_classifier'
require 'cv/filter'
require 'cv/selector'

module CV
  class TemplateMatchingAnalyzer
    def analyze
      tmc = CV::TemplateMatchingClassifier.new
      pais = tmc.classify("lib/cv/test_img/mj_5s_ng_003.jpg")

      filter = CV::Filter.new
      filtered_pais = filter.filter(pais)

      selector = CV::Selector.new
      selected_pais = selector.select(filtered_pais)
    end
  end
end
