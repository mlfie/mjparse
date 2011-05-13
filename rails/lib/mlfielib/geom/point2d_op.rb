module Mlfielib
  module Geom
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
        p_list.min |a, b| do
          distance(a) - distance(b)
        end
      end
    end
  end
end
