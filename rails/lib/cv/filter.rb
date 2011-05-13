require 'fitting/line_fitting'
require 'fitting/least_median_squares_line_fitting'

module CV
  class Filter
    def filter(pailist)
      fitting = Fitting::LeastMedianSquaresParamSearch.new(Fitting::LMSLineFittingModel.new(pailist))
      intercept, slope = fitting.search
    end
  end
end
