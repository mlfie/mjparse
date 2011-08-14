require 'opencv'

module Mlfielib
  module CV
    class ImageLoader
      include OpenCV
      def load(path, options={})
        color_scale = options[:color_scale] || CV_LOAD_IMAGE_GRAYSCALE
        rotate = options[:rotate] || 0
        mat = CvMat.load(path, color_scale)
        rotate_image(mat, rotate)
      end

      private
      def rotate_image(mat, rotate)
        rot = CvMat.rotation_matrix2D(CvPoint2D32f.new(0,0), rotate, 1.0)
        mat.warp_affine(rot)
      end
    end
  end
end
