require 'test_helper'

class ScoreCalculatorTest < ActiveSupport::TestCase

  test "20 fu tsumo pinfu" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, true)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    yaku1 = Yaku.new
    yaku1.name = 'pinfu'
    tehai.yaku_list << yaku1

    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = true
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 20
  end

  test "22 fu tsumo nomi" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, true)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = true
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 22
  end

  test "22 fu kanchan machi" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, true)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, false)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = false
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 22
  end

  test "22 fu penchan machi" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, true)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, false)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = false
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 22
  end

  test "22 fu tanki machi" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, false)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, true)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = false
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 22
  end

  test "26 fu chunchan koutsu tsumo" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('m2', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_KOUTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, true)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = true
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 26
  end

  test "30 fu yaochu koutsu tsumo" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, false)
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, false)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_KOUTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, true)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = true
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 30
  end

  test "30 fu yaochu koutsu shanpon tsumo" do
    mentsu_list = Array.new
    pai_list1 = Array.new
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, true)
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, true)
    pai_list1 << Mjt::Analysis::Pai.new('j7', false, true)
    mentsu1 = Mjt::Analysis::Mentsu.new(pai_list1, Mjt::Analysis::Mentsu::MENTSU_TYPE_KOUTSU)
    mentsu_list << mentsu1
    
    pai_list2 = Array.new
    pai_list2 << Mjt::Analysis::Pai.new('m1', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m2', false, false)
    pai_list2 << Mjt::Analysis::Pai.new('m3', false, false)
    mentsu2 = Mjt::Analysis::Mentsu.new(pai_list2, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu2
    
    pai_list3 = Array.new
    pai_list3 << Mjt::Analysis::Pai.new('p4', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p5', false, false)
    pai_list3 << Mjt::Analysis::Pai.new('p6', false, false)
    mentsu3 = Mjt::Analysis::Mentsu.new(pai_list3, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu3
    
    pai_list4 = Array.new
    pai_list4 << Mjt::Analysis::Pai.new('s7', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s8', false, false)
    pai_list4 << Mjt::Analysis::Pai.new('s9', false, false)
    mentsu4 = Mjt::Analysis::Mentsu.new(pai_list4, Mjt::Analysis::Mentsu::MENTSU_TYPE_SHUNTSU)
    mentsu_list << mentsu4
    
    atama = Mjt::Analysis::Pai.new('m1', false, false)
    
    tehai = Mjt::Analysis::Tehai.new(mentsu_list, atama)
    
    agari = Agari.new
    agari.is_parent = true
    agari.is_tsumo  = true
    agari.jikaze    = 'ton'
    agari.bakaze    = 'ton'
    
    fu_num = Mjt::Analysis::ScoreCalculator.calc_fu(tehai, agari)
    
    assert_equal fu_num, 30
  end

end