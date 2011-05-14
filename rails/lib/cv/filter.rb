require 'fitting/line_fitting'
require 'fitting/least_median_squares_line_fitting'

module CV
  class Filter
    attr_reader :origin, :vector
    def filter(pailist)
puts "erorr = #{14.0/pailist.size}"
      fitting = Fitting::LeastMedianSquaresParamSearch.new(Fitting::LMSLineFittingModel.new(pailist), 10.0/pailist.size)
      intercept, slope = fitting.search
      @origin = create_origin(intercept)
      @vector = create_vector(slope)
      pailist.select do |pai|
        nearby_line?(pai, @origin, @vector)
      end
    end

    def nearby_line?(pai, ori, vec)
      pai.distance_from_line(ori, vec) < pai.height * 0.5
    end

    def create_origin(intercept)
      Fitting::Point.new(0, intercept)
    end
    def create_vector(slope)
      Fitting::Point.new(1, slope)
    end
  end
end
