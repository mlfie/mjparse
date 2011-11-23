require 'opencv'
require 'mlfielib/cv/pai'

module Mlfielib
  module CV
    module TemplateMatching
      class TemplateMatcher
        include OpenCV

        attr_reader :type, :direction

        def symmetric?
          @symmetric
        end

        def initialize(params = {})
          raise ArgumentError, ":image_paths is required" if params[:image_paths].nil?
          @type = params[:type] || (raise ArgumentError, ":type is required")
          @direction = params[:direction] || :top
          @symmetric = params[:symmetric].nil? ? true : params[:symmetric]
          @threshold = params[:threshold] || 0.6
          @images = params[:image_paths].map {|path| CvMat.load(path, CV_LOAD_IMAGE_GRAYSCALE)}
        end

        def detect(target_img, scale=1.0)
          detected_pais = []
          @images.each do |img|
            scaled_img = img.resize(CvSize.new(img.cols * scale, img.rows * scale), :linear)
            detected_pais.concat(match_template(target_img, scaled_img))
            detected_pais.concat(match_template(target_img.flip(:xy), scaled_img)) unless symmetric?
          end
          return detected_pais
        end

        private
        def match_template(target_img, scaled_img)
          debug {
            @target_img_clone = target_img.clone
          }

          matched_pais = []
          result = target_img.match_template(scaled_img, CV_TM_CCOEFF_NORMED)
          min_val, max_val, min_loc, max_loc = result.min_max_loc

          while max_val > @threshold
            pai = CV::Pai.new(
              max_loc.x, max_loc.y, scaled_img.cols, scaled_img.rows, max_val, @type, @direction
            )
            matched_pais << pai

            debug {
              puts "#{pai.type}, #{pai.x}, #{pai.y}, #{pai.value}, #{pai.direction}"
              @target_img_clone.rectangle!(CvPoint.new(pai.left, pai.top), CvPoint.new(pai.right,pai.bottom), :color=>CvColor::Red, :thickness => 3)
              $__debug_window.show @target_img_clone
              GUI::wait_key
            }

            result.rectangle!(
              CvPoint.new(max_loc.x - scaled_img.cols/2, max_loc.y - scaled_img.rows/2),
              CvPoint.new(max_loc.x + scaled_img.cols/2, max_loc.y + scaled_img.rows/2),
              :color => CvColor::Black,
              :thickness => -1
            )
            min_val, max_val, min_loc, max_loc = result.min_max_loc
          end

          return matched_pais
        end

        def debug?
          @debug
        end

        def debug
          yield if debug?
        end
      end
    end
  end
end
