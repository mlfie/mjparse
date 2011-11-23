# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/web/tsumotter'


class CardChooserTest < Test::Unit::TestCase
  
  def setup
    super
    @tsumotter = Mlfielib::Web::Tsumotter.new
  end
  
  def teardown
    @tsumotter = nil
    super
  end

  def test_update
    @tsumotter.update("unit test message")
  end
end
