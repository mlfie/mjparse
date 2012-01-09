# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/tehai'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/yaku_judger'
require 'mlfielib/analysis/mentsu_resolver'

class YakuJudgerTest < Test::Unit::TestCase

  TON = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_TON
  NAN = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_NAN
  SHA = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_SHA
  PEI = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_PEI

  def setup
    yaku_specimen = Hash.new
    # yaku_specimen[name] = Mlfielib::Analysis::YakuSpecimen.new(name, kanji, han_num, naki_han_num)
    yaku_specimen['reach']      = Mlfielib::Analysis::YakuSpecimen.new('reach', '立直', 1, 0)
    yaku_specimen['tsumo']      = Mlfielib::Analysis::YakuSpecimen.new('tsumo', '門前清自摸和', 1, 1)
    yaku_specimen['dora']       = Mlfielib::Analysis::YakuSpecimen.new('dora', 'ドラ', 1, 1)
    @judger = Mlfielib::Analysis::YakuJudger.new(yaku_specimen)
    @resolver = Mlfielib::Analysis::MentsuResolver.new
  end
  
  def teardown
    
  end
  
  def test_normal_dora
    pai_items = "m1tm1tm1ts2ts3ts4tp5tp6tp7tm8tm8tm8ts9ts9t"
    @resolver.get_mentsu(pai_items)
    tehai = @resolver.tehai_list[0]
    
    kyoku = Mlfielib::Analysis::Kyoku.new
    kyoku.is_tsumo = false
    kyoku.is_haitei = false
    kyoku.dora_num = 3
    kyoku.bakaze = TON
    kyoku.jikaze = TON
    kyoku.honba_num = 0
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    kyoku.reach_num = 1
    kyoku.is_ippatsu = false
    kyoku.is_tenho = false
    kyoku.is_chiho = false
    kyoku.is_parent = true
    
    @judger.set_yaku_list(tehai, kyoku)
    
    assert_equal Mlfielib::Analysis::YakuJudger::RESULT_SUCCESS, @judger.result_code
    assert_equal 4, @judger.yaku_list.size
    dora_yaku_list = @judger.yaku_list.select {|yaku| yaku.name == 'dora'}
    assert_equal kyoku.dora_num, dora_yaku_list.size
  end
  
  def test_error_dora
    pai_items = "m1tm1tm1ts2ts3ts4tp5tp6tp7tm8tm8tm8ts9ts9t"
    @resolver.get_mentsu(pai_items)
    tehai = @resolver.tehai_list[0]
    
    kyoku = Mlfielib::Analysis::Kyoku.new
    kyoku.is_tsumo = false
    kyoku.is_haitei = false
    kyoku.dora_num = 3
    kyoku.bakaze = TON
    kyoku.jikaze = TON
    kyoku.honba_num = 0
    kyoku.is_rinshan = false
    kyoku.is_chankan = false
    kyoku.reach_num = 0
    kyoku.is_ippatsu = false
    kyoku.is_tenho = false
    kyoku.is_chiho = false
    kyoku.is_parent = true
    
    @judger.set_yaku_list(tehai, kyoku)
    
    assert_equal Mlfielib::Analysis::YakuJudger::RESULT_ERROR_YAKUNASHI, @judger.result_code
    assert_equal 0, @judger.yaku_list.size
    dora_yaku_list = @judger.yaku_list.select {|yaku| yaku.name == 'dora'}
    assert_not_equal kyoku.dora_num, dora_yaku_list.size
  end
end