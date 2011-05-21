module Mlfielib
  module Geom
    module PointOp
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
        p_dir = self - origin
        theta = dir.intersection_angle(p_dir)
        (distance(origin) * Math.sin(theta)).abs
      end
      def nearest(p_list)
        p_list.min do |a, b|
          distance(a) - distance(b)
        end
      end

      module Test
        #include this module to your point model
        def test_model_setup?
          assert @model, "you need to set @model in setup"
        end
        def test_respond_to_required_method?
          assert @model.respond_to?(:x), "model should respond to 'x'"
          assert @model.respond_to?(:y), "model should respond to 'y'"
          assert @model.respond_to?(:-), "model should respond to '-'"
        end
      end
    end
  end
end
