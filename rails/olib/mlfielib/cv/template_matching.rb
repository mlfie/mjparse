require 'opencv'
require 'mlfielib/cv/pai'

module Mlfielib
  module CV
    module TemplateMatching
      class BaseModel
        attr_accessor :threshold
        def initialize(threshold)
          @threshold = threshold
        end
        module Test
          def test_model_setup?
            assert @model, "you need to set @model at setup"
          end
          def test_respond_to_required_method?
            assert @model.respond_to?(:finish?),
              "model should respond to 'finish?'"
            assert @model.respond_to?(:matching_point),
              "model should respond to 'matching_point'"
            assert @model.respond_to?(:algorithm),
              "model should respond to 'algorithm'"
          end
        end
      end

      class CcoeffNormedModel < BaseModel
        include OpenCV
        def algorithm
          CV_TM_CCOEFF_NORMED
        end
        def matching_point(matching_result)
          min_val, max_val, min_loc, max_loc = matching_result.min_max_loc
          return max_val, max_loc.x, max_loc.y
        end
        def finish?(matching_value)
          matching_value < self.threshold
        end
      end
      class TemplateMatcher
        include OpenCV

        attr_accessor :threshold, :model
        attr_reader :template_path, :template_image

        def initialize(model, template_path)
          @template_path = template_path.clone
          @model = model
          load_image
        end

        def template_path
          return @template_path.clone
        end
        def template_image
          return @template_image.clone
        end

        def detect(target_image_path)
          target_image = IplImage.load(target_image_path, CV_LOAD_IMAGE_GRAYSCALE)

          pailist = []
          begin
            match_result = target_image.match_template(
              @template_image, @model.algorithm)
            val, x, y = @model.matching_point(match_result)
            p val
            fill_matched_rect(target_image, x, y)
            pailist << Mlfielib::CV::Pai.new(
              x, y, @template_image.cols, @template_image.rows, val
            )
          end until(@model.finish?(val))
          return pailist
        end

        private
        def load_image
          @template_image = IplImage.load(
            @template_path, CV_LOAD_IMAGE_GRAYSCALE)
        end
        def fill_matched_rect(target_image, x, y)
          target_image.rectangle!(
            CvPoint.new(x, y),
            CvPoint.new(x + @template_image.cols, y + @template_image.rows),
            :color => CvColor::White,
            :thichness => -1)
        end
      end
    end
  end
end
