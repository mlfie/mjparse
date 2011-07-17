module Mlfielib
  module CV
    module TemplateMatching
      class Model
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
    end
  end
end
