require 'fitting/line_fitting'
require 'fitting/least_median_squares_line_fitting'

module CV
  class Filter
    def filter(pailist)
      fitting = Fitting::LeastMedianSquaresParamSearch.new(Fitting::LMSLineFittingModel.new(pailist))
      intercept, slope = fitting.search
      o = origin(intercept)
      v = vector(slope)
      pailist.select do |pai|
        nearby_line?(pai, o, v)
      end
    end

    def nearby_line?(pai, ori, vec)
      pai.distance_from_line(ori, vec) < pai.height * 0.8
    end

    def origin(intercept)
      Fitting::Point.new(0, intercept)
    end
    def vector(slope)
      Fitting::Point.new(1, slope)
    end
  end
end
