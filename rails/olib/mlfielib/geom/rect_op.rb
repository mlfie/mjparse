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
        position.x
      end
      def top
        position.y
      end
      def right
        left + width
      end
      def bottom
        top + height
      end

      module Test
        def test_model_setup?
          assert @model, "you need to set @model at setup"
        end
        def test_respond_to_required_method?
          assert @model.respond_to?(:position), "model should respond to 'position'"
          assert @model.respond_to?(:width), "model should respond to 'width'"
          assert @model.respond_to?(:height), "model should respond to 'height'"
          assert @model.position.respond_to?(:x), "model.position should respond to 'x'"
          assert @model.position.respond_to?(:y), "model.position should respond to 'y'"
        end
      end
    end
  end
end
