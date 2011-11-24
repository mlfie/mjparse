require 'opencv'

module Mlfielib
  module CV
    class Selector
      include OpenCV

      def select(pais)
        selected = []
        pais = pais.sort{|a,b| a.value <=> b.value}
        pais.each do |pai|
          nearest = pai.nearest(selected)
          if nearest && (pai.intersect_area(nearest) / pai.area) > 0.15
          #if nearest && pai.intersect?(nearest)
            if pai.value > nearest.value
              selected.delete(nearest)
              selected << pai
            end
          else
            selected << pai
          end

          debug {
            selected.each {|p|
              $__test_img.rectangle!(CvPoint.new(p.left,p.top),CvPoint.new(p.right,p.bottom),
                             :color => CvColor::Green, :thickness => 3)
            }
            $__debug_window.show $__test_img
            GUI::wait_key
          }
        end
        return selected
      end

      def debug?
        false
      end

      def debug
        yield if debug?
      end
    end
  end
end
