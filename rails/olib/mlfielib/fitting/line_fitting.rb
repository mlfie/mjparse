require 'mlfielib/geom/point'

module Mlfielib
  module Fitting
    class LeastDistanceSquaresLineFitting
      class Result
        attr_accessor :slope, :intercept
        def initialize(slope, intercept)
          self.slope = slope
          self.intercept = intercept
        end
      end
  
      attr_reader :points
  
      def initialize
        @points = Array.new
      end
  
      def add(point)
        @points << point
      end
  
      def fit
        total = {:xx => 0, :xd => 0, :xy => 0, :yd => 0, :yy => 0, :dd => 0}
        d = 1
        sum = @points.inject(total) {|t, p|
          t[:xx] += p.x * p.x
          t[:xd] += p.x * d
          t[:xy] += p.x * p.y
          t[:yd] += p.y * d
          t[:yy] += p.y * p.y
          t[:dd] += d * d
          t
        }
        Result.new(slope(sum), intercept(sum))
      end
  
      private
      def slope(t)
        n = t[:dd]
        d = t[:xy]
        c = t[:yd]
        e = t[:xd]
        b = t[:xx]
        return (n*d - c*e) / (n*b - e*e)
      end
  
      def intercept(t)
        n = t[:dd]
        d = t[:xy]
        c = t[:yd]
        e = t[:xd]
        b = t[:xx]
        return (b*c - d*e) / (n*b - e*e)
      end
    end
  end
end
