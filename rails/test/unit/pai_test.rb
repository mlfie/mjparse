require 'test_helper'

class PaiTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "create" do
    pai = Mjt::Analysis::Pai.new('m1', false)
    assert_equal pai.type, 'm'
    assert_equal pai.number, 1
    assert_equal pai.is_agari, false
  end
end
