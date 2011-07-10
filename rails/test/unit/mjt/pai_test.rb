require 'test_helper'

class PaiTest < ActiveSupport::TestCase
  # 作成テスト
  test "create" do
    pai = Mjt::Analysis::Pai.new('m1', false, true)
    assert_equal pai.type, 'm'
    assert_equal pai.number, 1
    assert_equal pai.naki, false
    assert_equal pai.agari, true
  end
  
  test "==" do
    pai1 = Mjt::Analysis::Pai.new('m1', false, false)
    pai2 = Mjt::Analysis::Pai.new('m1', false, false)
    assert_equal pai1==pai2, true
  end
  
  test "yaochu" do
    pai1 = Mjt::Analysis::Pai.new('m2', false, false)
    pai2 = Mjt::Analysis::Pai.new('m1', false, false)
    pai3 = Mjt::Analysis::Pai.new('j2', false, false)
    assert_equal pai1.yaochu?, false
    assert_equal pai2.yaochu?, true
    assert_equal pai3.yaochu?, true
  end
  
  test "chunchan" do
    pai1 = Mjt::Analysis::Pai.new('m2', false, false)
    pai2 = Mjt::Analysis::Pai.new('m1', false, false)
    pai3 = Mjt::Analysis::Pai.new('j2', false, false)
    pai4 = Mjt::Analysis::Pai.new('m8', false, false)
    assert_equal pai1.chunchan?, true
    assert_equal pai2.chunchan?, false
    assert_equal pai3.chunchan?, false
    assert_equal pai4.chunchan?, true
  end
  
  test "manzu" do
    pai1 = Mjt::Analysis::Pai.new('m1', false, false)
    pai2 = Mjt::Analysis::Pai.new('s1', false, false)
    pai3 = Mjt::Analysis::Pai.new('p1', false, false)
    pai4 = Mjt::Analysis::Pai.new('j1', false, false)
    assert_equal pai1.manzu?, true
    assert_equal pai2.manzu?, false
    assert_equal pai3.manzu?, false
    assert_equal pai4.manzu?, false
  end
  
  test "souzu" do
    pai1 = Mjt::Analysis::Pai.new('m1', false, false)
    pai2 = Mjt::Analysis::Pai.new('s1', false, false)
    pai3 = Mjt::Analysis::Pai.new('p1', false, false)
    pai4 = Mjt::Analysis::Pai.new('j1', false, false)
    assert_equal pai1.souzu?, false
    assert_equal pai2.souzu?, true
    assert_equal pai3.souzu?, false
    assert_equal pai4.souzu?, false
  end
  
  test "pinzu" do
    pai1 = Mjt::Analysis::Pai.new('m1', false, false)
    pai2 = Mjt::Analysis::Pai.new('s1', false, false)
    pai3 = Mjt::Analysis::Pai.new('p1', false, false)
    pai4 = Mjt::Analysis::Pai.new('j1', false, false)
    assert_equal pai1.pinzu?, false
    assert_equal pai2.pinzu?, false
    assert_equal pai3.pinzu?, true
    assert_equal pai4.pinzu?, false
  end
  
  test "jihai" do
    pai1 = Mjt::Analysis::Pai.new('m1', false, false)
    pai2 = Mjt::Analysis::Pai.new('s1', false, false)
    pai3 = Mjt::Analysis::Pai.new('p1', false, false)
    pai4 = Mjt::Analysis::Pai.new('j1', false, false)
    assert_equal pai1.jihai?, false
    assert_equal pai2.jihai?, false
    assert_equal pai3.jihai?, false
    assert_equal pai4.jihai?, true
  end
  
  test "jihai ton" do
    pai1 = Mjt::Analysis::Pai.new('j1', false, false)
    pai2 = Mjt::Analysis::Pai.new('j2', false, false)
    pai3 = Mjt::Analysis::Pai.new('j3', false, false)
    pai4 = Mjt::Analysis::Pai.new('j4', false, false)
    pai5 = Mjt::Analysis::Pai.new('m1', false, false)
    assert_equal pai1.ton?, true
    assert_equal pai2.ton?, false
    assert_equal pai3.ton?, false
    assert_equal pai4.ton?, false
    assert_equal pai5.ton?, false
  end
  
  test "jihai nan" do
    pai1 = Mjt::Analysis::Pai.new('j1', false, false)
    pai2 = Mjt::Analysis::Pai.new('j2', false, false)
    pai3 = Mjt::Analysis::Pai.new('j3', false, false)
    pai4 = Mjt::Analysis::Pai.new('j4', false, false)
    pai5 = Mjt::Analysis::Pai.new('m2', false, false)
    assert_equal pai1.nan?, false
    assert_equal pai2.nan?, true
    assert_equal pai3.nan?, false
    assert_equal pai4.nan?, false
    assert_equal pai5.nan?, false
  end
  
  test "jihai sha" do
    pai1 = Mjt::Analysis::Pai.new('j1', false, false)
    pai2 = Mjt::Analysis::Pai.new('j2', false, false)
    pai3 = Mjt::Analysis::Pai.new('j3', false, false)
    pai4 = Mjt::Analysis::Pai.new('j4', false, false)
    pai5 = Mjt::Analysis::Pai.new('m3', false, false)
    assert_equal pai1.sha?, false
    assert_equal pai2.sha?, false
    assert_equal pai3.sha?, true
    assert_equal pai4.sha?, false
    assert_equal pai5.sha?, false
  end
  
  test "jihai pei" do
    pai1 = Mjt::Analysis::Pai.new('j1', false, false)
    pai2 = Mjt::Analysis::Pai.new('j2', false, false)
    pai3 = Mjt::Analysis::Pai.new('j3', false, false)
    pai4 = Mjt::Analysis::Pai.new('j4', false, false)
    pai5 = Mjt::Analysis::Pai.new('m4', false, false)
    assert_equal pai1.pei?, false
    assert_equal pai2.pei?, false
    assert_equal pai3.pei?, false
    assert_equal pai4.pei?, true
    assert_equal pai5.pei?, false
  end
  
  test "jihai haku" do
    pai1 = Mjt::Analysis::Pai.new('j5', false, false)
    pai2 = Mjt::Analysis::Pai.new('j6', false, false)
    pai3 = Mjt::Analysis::Pai.new('j7', false, false)
    pai4 = Mjt::Analysis::Pai.new('m5', false, false)
    assert_equal pai1.haku?, true
    assert_equal pai2.haku?, false
    assert_equal pai3.haku?, false
    assert_equal pai4.haku?, false
  end
  
  test "jihai hatsu" do
    pai1 = Mjt::Analysis::Pai.new('j5', false, false)
    pai2 = Mjt::Analysis::Pai.new('j6', false, false)
    pai3 = Mjt::Analysis::Pai.new('j7', false, false)
    pai4 = Mjt::Analysis::Pai.new('m6', false, false)
    assert_equal pai1.hatsu?, false
    assert_equal pai2.hatsu?, true
    assert_equal pai3.hatsu?, false
    assert_equal pai4.hatsu?, false
  end
  
  test "jihai chun" do
    pai1 = Mjt::Analysis::Pai.new('j5', false, false)
    pai2 = Mjt::Analysis::Pai.new('j6', false, false)
    pai3 = Mjt::Analysis::Pai.new('j7', false, false)
    pai4 = Mjt::Analysis::Pai.new('m7', false, false)
    assert_equal pai1.chun?, false
    assert_equal pai2.chun?, false
    assert_equal pai3.chun?, true
    assert_equal pai4.chun?, false
  end
end
