require 'test_helper'
require 'util/card_chooser'

class CardChooserTest < ActiveSupport::TestCase
  def setup
    @size = 10
    @chooser = Util::CardChooser.new(@size)
  end

  test "current_size" do
    assert_equal @size, @chooser.current_size
    @chooser.choose(0)
    assert_equal @size-1, @chooser.current_size
  end

  test "choose and undo" do
    choosed = []
    @size.times do
      choosed << @chooser.choose(rand(@chooser.current_size))
    end
    @size.times do
      assert_equal choosed.pop, @chooser.undo
    end
  end

end
