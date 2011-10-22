require 'mlfielib/util/card_chooser'

module Mlfielib
  module Fitting
    class LeastMedianSquaresParamSearch
      attr_accessor :fitting_model, :error_ratio, :step_num
      def initialize(fitting_model, error_ratio = 0.5, step_num = 0)
        self.fitting_model = fitting_model
        self.error_ratio = error_ratio
        self.step_num = step_num == 0 ? estimated_step_num : step_num
      end
  
      def estimated_step_num
        return 100
      end
  
      def search
        min = Float::MAX
        min_param = nil
        step_num.times {
          samples = fitting_model.extract_samples
          param = fitting_model.calc_parameter(samples)
          res = fitting_model.median_residual(param, error_ratio)
          if res < min
            min = res
            min_param = param
          end
          fitting_model.release_samples
        }
        return min_param
      end
  
    end
  
    class LMSLineFittingModel
      def initialize(points)
        @points = points
        @chooser = Mlfielib::Util::CardChooser.new(@points.size)
      end
  
      def sample_number
        return 2
      end
  
      def extract_samples
        samples = []
        sample_number.times do
          samples << @points[@chooser.choose(rand(@chooser.current_size))]
        end
        return samples
      end
  
      def release_samples
        sample_number.times do
          @chooser.undo
        end
      end
  
      def calc_parameter(samples)
        slope = (samples[0].y - samples[1].y) / (samples[0].x - samples[1].x + 0.000001)
        intercept = samples[0].y - slope * samples[0].x
        return intercept, slope
      end
  
      def residual(param, point)
        res = point.y - param[1] * point.x - param[0]
        return res * res
      end
  
      def median_residual(param, error_ratio)
        residuals = @points.map{|p| residual(param, p)}.sort 
        idx = (@points.size * error_ratio).floor
        return residuals[idx]
      end
    end
  end
end
