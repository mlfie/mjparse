module Mlfielib
  module Geom
    module RectOp
      def intersect?(r)
        (left <= r.right) && (r.left <= right) &&
          (top <= r.bottom) && (r.top <= bottom)
      end

      def intersect_area(r)
        return 0 unless intersect?(r)
        ([(left - r.right).abs, (right - r.left).abs].min * 
          [(top - r.bottom).abs, (bottom - r.top).abs].min).to_f
      end

      def area
        (width * height).to_f
      end

      def left
        x
      end
      def top
        y
      end
      def right
        x + width
      end
      def bottom
        y + height
      end

    end
    module Point2DOp
      def distance(p)
        Math.sqrt((x-p.x)**2 + (y-p.y)**2)
      end
      def dot_product(p)
        x*p.x + y*p.y
      end
      def cross_product(p)
        x*p.y - y*p.x
      end
      def intersection_angle(p)
        Math.atan2(cross_product(p), dot_product(p))
      end
      def distance_from_line(origin, dir)
        p_dir = minus(origin)
        theta = dir.intersection_angle(p_dir)
        (distance(origin) * Math.sin(theta)).abs
      end
      def nearest(p_list)
        p_list.min do |a, b|
          distance(a) - distance(b)
        end
      end
    end
  end
end
