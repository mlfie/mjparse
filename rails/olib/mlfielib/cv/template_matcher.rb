require 'opencv'
require 'mlfielib/cv/pai'

module Mlfielib
  module CV
    class TemplateMatcher
      include OpenCV

      attr_accessor :threshold, :algorithm
      attr_reader :template_path, :template_image

      DEFAULT_THRESHOLD = 0.6
      DEFAULT_ALGORITHM = :ccoeff_normed

      @opencv_match_algorithm_map = {
        :ccoeff_normed => CV_TM_CCOEFF_NORMED
      }

      def initialize(template_path, options = {})
        @template_path = template_path.clone
        load_image
        @threshold = options[:threshold] || DEFAULT_THRESHOLD
        @algorithm = options[:algorithm] || DEFAULT_ALGORITHM
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
          min_val, max_val, min_loc, max_loc =
            target_image.match_template(
              @template_image, TemplateMatcher.opencv_algorithm_name(@algorithm)
            ).min_max_loc
          target_image.rectangle!(CvPoint.new(max_loc.x, max_loc.y),
                                  CvPoint.new(max_loc.x + @template_image.cols, max_loc.y + @template_image.rows),
                                  :color => CvColor::White,
                                  :thichness => -1)
          pailist << Mlfielib::CV::Pai.new(
            max_loc.x, max_loc.y, @template_image.cols, @template_image.rows,
            max_val
          )
        end while(max_val > @threshold)
        return pailist
      end

      def self.opencv_algorithm_name(algorithm)
        @opencv_match_algorithm_map[algorithm]
      end

      private
      def load_image
        @template_image = IplImage.load(@template_path, CV_LOAD_IMAGE_GRAYSCALE)
      end
    end
  end
end
