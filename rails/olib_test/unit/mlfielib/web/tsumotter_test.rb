# -*- coding: utf-8 -*-
require 'date'
require 'test/unit'
require 'test_helper'
require 'mlfielib/web/tsumotter'


class TsumotterTest < Test::Unit::TestCase
  
  def setup
    super
    @tsumotter = Mlfielib::Web::Tsumotter.new
  end
  
  def teardown
    @tsumotter = nil
    super
  end

  def test_update
    @tsumotter.update("unit test message at " + Time.new.to_s)
  end
end
