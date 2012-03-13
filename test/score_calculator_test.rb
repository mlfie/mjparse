# -*- coding: utf-8 -*-
require 'test_helper'

class ScoreCalculatorTest < Test::Unit::TestCase
  
  TON = Mjparse::Kyoku::KYOKU_KAZE_TON
  NAN = Mjparse::Kyoku::KYOKU_KAZE_NAN
  SHA = Mjparse::Kyoku::KYOKU_KAZE_SHA
  PEI = Mjparse::Kyoku::KYOKU_KAZE_PEI

  YAKU_NAME_REACH     = Mjparse::YakuSpecimen::YAKU_NAME_REACH
  YAKU_NAME_TSUMO     = Mjparse::YakuSpecimen::YAKU_NAME_TSUMO
  YAKU_NAME_PINFU     = Mjparse::YakuSpecimen::YAKU_NAME_PINFU
  YAKU_NAME_CHITOITSU = Mjparse::YakuSpecimen::YAKU_NAME_CHITOITSU

  ScoreCalculator     = Mjparse::ScoreCalculator

  def setup
    super
    yaku_specimen = Hash.new
    # yaku_specimen[name] = Mjparse::YakuSpecimen.new(name, kanji, han_num, naki_han_num)
    yaku_specimen[YAKU_NAME_REACH]      = Mjparse::YakuSpecimen.new(YAKU_NAME_REACH, '立直', 1, 0)
    yaku_specimen[YAKU_NAME_TSUMO]      = Mjparse::YakuSpecimen.new(YAKU_NAME_TSUMO, '門前清自摸和', 1, 1)
    yaku_specimen[YAKU_NAME_PINFU]      = Mjparse::YakuSpecimen.new(YAKU_NAME_PINFU, '平和', 1, 0)
    yaku_specimen[YAKU_NAME_CHITOITSU]  = Mjparse::YakuSpecimen.new(YAKU_NAME_CHITOITSU, '七対子', 2, 0)
    @judger   = Mjparse::YakuJudger.new(yaku_specimen)
    @resolver = Mjparse::MentsuResolver.new
    @kyoku    = Mjparse::Kyoku.new
  end
  
  def teardown
    @judger   = nil
    @resolver = nil
    @kyoku    = nil
    super
  end
  
#*****************************************************************#
# step1. 符を計算する
#*****************************************************************#
  def test_calc_fu_chitoitsu
    pai_items = "m1tm1ts1ts1tp1tp1tm3tm3ts3ts3tp3tp3tj1tj1t"
    @resolver.get_mentsu(pai_items)
    tehai = @resolver.tehai_list[0]
    @judger.set_yaku_list(tehai, @kyoku)
    chitoitsu_list = @judger.yaku_list.select {|yaku| yaku.name == YAKU_NAME_CHITOITSU}
    assert_equal 1, chitoitsu_list.size
    tehai.yaku_list = @judger.yaku_list

    fu_num = ScoreCalculator.calc_fu(tehai, @kyoku)
    assert_equal 25, fu_num
  end
  
  def test_calc_fu_tsumo_pinfu
    pai_items = "m1tm2tm3ts4ts5ts6tp7tp8tp9ts9ts9tm4tm5tm6t"
    @resolver.get_mentsu(pai_items)
    tehai = @resolver.tehai_list[0]
    @judger.set_yaku_list(tehai, @kyoku)
    pinfu_list = @judger.yaku_list.select {|yaku| yaku.name == YAKU_NAME_PINFU}
    assert_equal 1, pinfu_list.size
    tehai.yaku_list = @judger.yaku_list

    @kyoku.is_tsumo = true
    fu_num = ScoreCalculator.calc_fu(tehai, @kyoku)
    assert_equal 20, fu_num
  end
  
#*****************************************************************#
# step2. 飜を計算する
#*****************************************************************#
  def test_calc_han_yakunashi
    tehai = Mjparse::Tehai.new(nil, nil, false)
    tehai.yaku_list = Array.new
    han_num = ScoreCalculator.calc_han(tehai, @kyoku)
    assert_equal 0, han_num
  end
  
  def test_calc_han_menzen
    tehai = Mjparse::Tehai.new(nil, nil, false)
    tehai.yaku_list = Array.new
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_REACH, '立直', 1, 0)
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_TSUMO, '門前清自摸和', 1, 1)
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_CHITOITSU, '七対子', 2, 0)
    @kyoku.dora_num = 1

    han_num = ScoreCalculator.calc_han(tehai, @kyoku)
    assert_equal 5, han_num
  end
  
  def test_calc_han_naki
    tehai = Mjparse::Tehai.new(nil, nil, true)
    tehai.yaku_list = Array.new
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_REACH, '立直', 1, 0)
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_TSUMO, '門前清自摸和', 1, 1)
    tehai.yaku_list << Mjparse::YakuSpecimen.new(YAKU_NAME_CHITOITSU, '七対子', 2, 0)
    @kyoku.dora_num = 1

    han_num = ScoreCalculator.calc_han(tehai, @kyoku)
    assert_equal 2, han_num
  end

  def test_calc_han_with_dora_and_no_yaku
    tehai = Mjparse::Tehai.new(nil, nil, true)
    tehai.yaku_list = Array.new
    @kyoku.dora_num = 1

    han_num = ScoreCalculator.calc_han(tehai, @kyoku)
    assert_equal 0, han_num
  end

#*****************************************************************#
# step3. 満貫の倍数を計算する
#*****************************************************************#
  def test_calc_mangan_scale_none
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num =  3
    tehai1.fu_num  = 60
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 0, scale1
    
    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num =  4 
    tehai2.fu_num  = 30
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 0, scale2
  end
  
  def test_calc_mangan_scale_mangan
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num =  3
    tehai1.fu_num  = 70
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 1, scale1

    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num =  4 
    tehai2.fu_num  = 40
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 1, scale2

    tehai3 = Mjparse::Tehai.new(nil, nil, true)
    tehai3.han_num =  5
    tehai3.fu_num  = 30
    scale3 = ScoreCalculator.calc_mangan_scale(tehai3, @kyoku)
    assert_equal 1, scale3
  end
  
  def test_calc_mangan_scale_haneman
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num =  6
    tehai1.fu_num  = 30
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 1.5, scale1

    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num =  7 
    tehai2.fu_num  = 30
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 1.5, scale2
  end
  
  def test_calc_mangan_scale_baiman
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num =  8
    tehai1.fu_num  = 30
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 2, scale1

    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num =  9 
    tehai2.fu_num  = 30
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 2, scale2

    tehai3 = Mjparse::Tehai.new(nil, nil, true)
    tehai3.han_num = 10
    tehai3.fu_num  = 30
    scale3 = ScoreCalculator.calc_mangan_scale(tehai3, @kyoku)
    assert_equal 2, scale3
  end
  
  def test_calc_mangan_scale_sanbaiman
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num = 11
    tehai1.fu_num  = 30
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 3, scale1

    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num = 12 
    tehai2.fu_num  = 30
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 3, scale2
  end
  
  def test_calc_mangan_scale_yakuman
    tehai1 = Mjparse::Tehai.new(nil, nil, true)
    tehai1.han_num = 13
    tehai1.fu_num  = 30
    scale1 = ScoreCalculator.calc_mangan_scale(tehai1, @kyoku)
    assert_equal 4, scale1

    tehai2 = Mjparse::Tehai.new(nil, nil, true)
    tehai2.han_num = 14 
    tehai2.fu_num  = 30
    scale2 = ScoreCalculator.calc_mangan_scale(tehai2, @kyoku)
    assert_equal 4, scale2

    tehai3 = Mjparse::Tehai.new(nil, nil, true)
    tehai3.han_num = 26
    tehai3.fu_num  = 30
    scale3 = ScoreCalculator.calc_mangan_scale(tehai3, @kyoku)
    assert_equal 8, scale3
  end

#*****************************************************************#
# step4. 符と翻から得点を計算する
#*****************************************************************#

#*****************************************************************#
# step5. ツモアガリの際に親が払う点数を計算する
#*****************************************************************#

#*****************************************************************#
# step6. ツモアガリの際に子が払う点数を計算する
#*****************************************************************#

#*****************************************************************#
# step7. ロンアガリの際に放銃した人が払う点数を計算する
#*****************************************************************#

#*****************************************************************#
# step8. 最終的な総得点を計算する
#*****************************************************************#

#*****************************************************************#
# ユーティリティ系
#*****************************************************************#
  def test_ceil_one_level_zero
    result = ScoreCalculator.ceil_one_level(8000)
    assert_equal 8000, result
  end

  def test_ceil_one_level_one
    result = ScoreCalculator.ceil_one_level(8001)
    assert_equal 8010, result
  end

  def test_ceil_one_level_nine
    result = ScoreCalculator.ceil_one_level(8009)
    assert_equal 8010, result
  end

  def test_ceil_ten_level_zero
    result = ScoreCalculator.ceil_ten_level(8000)
    assert_equal 8000, result
  end

  def test_ceil_ten_level_one
    result = ScoreCalculator.ceil_ten_level(8010)
    assert_equal 8100, result
  end

  def test_ceil_ten_level_nine
    result = ScoreCalculator.ceil_ten_level(8090)
    assert_equal 8100, result
  end
  
end
