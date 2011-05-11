require 'test_helper'
require 'fitting/line_fitting'

class PointTest < ActiveSupport::TestCase
  test "Point" do
    p = Fitting::Point.new
    assert p
  end
end
