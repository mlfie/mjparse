require 'test/unit'
require 'test_helper'
require 'mlfielib/util/card_chooser'

class CardChooserTest < Test::Unit::TestCase
  def setup
    @size = 10
    @chooser = Mlfielib::Util::CardChooser.new(@size)
  end

  def test_current_size
    @size = 10
    @chooser = Mlfielib::Util::CardChooser.new(@size)
    assert_equal @size, @chooser.current_size
    @chooser.choose(0)
    assert_equal @size-1, @chooser.current_size
  end

  def test_choose_and_undo
    @size = 10
    @chooser = Mlfielib::Util::CardChooser.new(@size)
    choosed = []
    @size.times do
      choosed << @chooser.choose(rand(@chooser.current_size))
    end
    @size.times do
      assert_equal choosed.pop, @chooser.undo
    end
  end

end
