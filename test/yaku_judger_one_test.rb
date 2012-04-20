# -*- coding: utf-8 -*-
require 'test_helper'

class YakuJudgerOneTest < Test::Unit::TestCase
  #Constants
  TON = Mjparse::Kyoku::KYOKU_KAZE_TON
  NAN = Mjparse::Kyoku::KYOKU_KAZE_NAN
  SHA = Mjparse::Kyoku::KYOKU_KAZE_SHA
  PEI = Mjparse::Kyoku::KYOKU_KAZE_PEI
  
  def setup
    yaku_specimen = Hash.new
    # yaku_specimen[name] = Mjparse::YakuSpecimen.new(name, kanji, han_num, naki_han_num)
    @judger = Mjparse::YakuJudger.new(yaku_specimen)
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def teardown
    
  end
  
  def test_reach
    agari = Mjparse::Kyoku.new
    
    agari.reach_num = 0
    assert_equal false, @judger.reach?(nil, agari)
    agari.reach_num = 1
    assert_equal true, @judger.reach?(nil, agari)
  end
  
  def test_pinfu
    agari = Mjparse::Kyoku.new
    agari.bakaze = TON
    #一番右があがり牌
    #m2tm3t p1tp2tp3t s1ts2ts3t s6ts7ts8t j2j2 m1t
    pai_items = "m2tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2tm1t"    
    @resolver.get_mentsu(pai_items)
    
    #リャンメンであがり --> true
    @resolver.tehai_list.each do |tehai|
      #m1があがり牌
      assert_equal true, @judger.pinfu?(tehai, agari)
    end
    
    #雀頭が役牌の風牌  --> false
    agari.bakaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    agari.bakaze = TON    
    @resolver = Mjparse::MentsuResolver.new
    
    #雀頭が役牌  --> false
    pai_items = "m2tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj5tj5tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #カンチャンであがり --> false
    pai_items = "m1tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #ペンチャンであがり  --> false
    pai_items = "m1tm2tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2tm3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #単キであがり  --> false
    pai_items = "m1tm2tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #あんこうが存在  --> false
    pai_items = "m2tm3tp2tp2tp2ts1ts2ts3ts6ts7ts8tj2tj2tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #鳴きがある  --> false
    pai_items = "p1tp2tp3ts1ts2ts3ts6ts7tj2tj2ts8tm1rm2tm3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #test001 --> true
    pai_items = "m6tm7tm8tp8tp7tp6ts6ts7ts8tp1tp1tp4tp5tp6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal true, @judger.pinfu?(tehai, agari)
    end
    @resolver = Mjparse::MentsuResolver.new
    
  end
  
  
  def test_tanyao
    #正常系  --> true
    pai_items = "m3tm4tp2tp2tp2ts2ts3ts4ts6ts7ts8tp8tp8tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal true, @judger.tanyao?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
    #メンツに１、９がある  --> false
    pai_items = "m3tm4tp2tp2tp2ts2ts3ts4ts7ts8ts9tp8tp8tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.tanyao?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new

    #メンツに字牌がある  --> false
    pai_items = "m3tm4tj2tj2tj2ts2ts3ts4ts6ts7ts8tp8tp8tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.tanyao?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new  

    #あたまに１、９がある  --> false
    pai_items = "m3tm4tp2tp2tp2ts2ts3ts4ts6ts7ts8tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.tanyao?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #あたまに字牌がある  --> false
    pai_items = "m3tm4tp2tp2tp2ts2ts3ts4ts6ts7ts8tj3tj3tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.tanyao?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def test_iipeikou
    #正常系  --> true
    pai_items = "m3tm4tp2tp2tp2ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal true, @judger.iipeikou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    #鳴きがある  --> false
    pai_items = "p2tp2ts2ts2ts3ts3ts4ts4tp9tp9tp2tm2rm3tm4t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.iipeikou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # ３暗刻含みの場合  --> false 寺師のところで高いほうの役でとってくれるのでテストしなくてよい
    # m1m1m1m2m2m2m3m3m3s1s2s3j1j1
    #pai_items = "m1tm1tm1tm2tm2tm2tm3tm3tm3ts1ts2ts3tj1tj1t"    
    #@resolver.get_mentsu(pai_items)
    
    #@resolver.tehai_list.each do |tehai|
    #  assert_equal false, @judger.iipeikou?(tehai, nil)
    #end
    #@resolver = Mjparse::MentsuResolver.new
    
  end
  
  def test_ippatsu
    agari = Mjparse::Kyoku.new
    
    agari.is_ippatsu = false
    assert_equal false, @judger.ippatsu?(nil, agari)
    agari.is_ippatsu = true
    assert_equal true, @judger.ippatsu?(nil, agari)
  end
  
  def test_tsumo
    agari = Mjparse::Kyoku.new
    pai_items = "j1tj1tj1tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    agari.is_tsumo = false
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.tsumo?(tehai, agari)
    end
    agari.is_tsumo = true
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.tsumo?(tehai, agari)
    end

  end

  def test_tsumo_with_naki
    agari = Mjparse::Kyoku.new
    pai_items = "j1tj1tj1tm3tm4ts2ts3ts4tp9tp9tm2ts2ls3ts4t"    
    @resolver.get_mentsu(pai_items)

    agari.is_tsumo = true
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.tsumo?(tehai, agari)
    end
  end
  
  def test_ton
    agari = Mjparse::Kyoku.new
    pai_items = "j1tj1tj1tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
   
    #場風が東、自風が南  --> true
    agari.bakaze = TON
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazeton?(tehai, agari)
      assert_equal false, @judger.jikazeton?(tehai, agari)
    end
    
    #場風が南、自風が東  --> true
    agari.bakaze = NAN
    agari.jikaze = TON
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazeton?(tehai, agari)
      assert_equal true, @judger.jikazeton?(tehai, agari)
    end
   
   #場風が東、自風が東  --> true
    agari.bakaze = TON
    agari.jikaze = TON
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazeton?(tehai, agari)
      assert_equal true, @judger.jikazeton?(tehai, agari)
    end
    #場風が南、自風が南  --> false
    agari.bakaze = NAN
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazeton?(tehai, agari)
      assert_equal false, @judger.jikazeton?(tehai, agari)
    end
  end
   
  def test_nan
    agari = Mjparse::Kyoku.new
    pai_items = "j2tj2tj2tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
   
    #場風が南、自風が西  --> true
    agari.bakaze = NAN
    agari.jikaze = SHA
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazenan?(tehai, agari)
      assert_equal false, @judger.jikazenan?(tehai, agari)
    end
    
    #場風が西、自風が南  --> true
    agari.bakaze = SHA
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazenan?(tehai, agari)
      assert_equal true, @judger.jikazenan?(tehai, agari)
    end
   
   #場風が南、自風が南  --> true
    agari.bakaze = NAN
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazenan?(tehai, agari)
      assert_equal true, @judger.jikazenan?(tehai, agari)
    end
    #場風が西、自風が西  --> false
    agari.bakaze = SHA
    agari.jikaze = SHA
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazenan?(tehai, agari)
      assert_equal false, @judger.jikazenan?(tehai, agari)
    end
  end
    
  def test_sha
    agari = Mjparse::Kyoku.new
    pai_items = "j3tj3tj3tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
   
    #場風が西、自風が南  --> true
    agari.bakaze = SHA
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazesha?(tehai, agari)
      assert_equal false, @judger.jikazesha?(tehai, agari)
    end
    
    #場風が南、自風が西  --> true
    agari.bakaze = NAN
    agari.jikaze = SHA
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazesha?(tehai, agari)
      assert_equal true, @judger.jikazesha?(tehai, agari)
    end
   
   #場風が西、自風が西  --> true
    agari.bakaze = SHA
    agari.jikaze = SHA
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazesha?(tehai, agari)
      assert_equal true, @judger.jikazesha?(tehai, agari)
    end
    #場風が南、自風が南  --> false
    agari.bakaze = NAN
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazesha?(tehai, agari)
      assert_equal false, @judger.jikazesha?(tehai, agari)
    end
  end
    
  def test_pei
    agari = Mjparse::Kyoku.new
    pai_items = "j4tj4tj4tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
   
    #場風が北、自風が南  --> true
    agari.bakaze = PEI
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazepei?(tehai, agari)
      assert_equal false, @judger.jikazepei?(tehai, agari)
    end
    
    #場風が北、自風が東  --> true
    agari.bakaze = NAN
    agari.jikaze = PEI
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazepei?(tehai, agari)
      assert_equal true, @judger.jikazepei?(tehai, agari)
    end
   
   #場風が北、自風が北  --> true
    agari.bakaze = PEI
    agari.jikaze = PEI
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.bakazepei?(tehai, agari)
      assert_equal true, @judger.jikazepei?(tehai, agari)
    end
    #場風が南、自風が南  --> false
    agari.bakaze = NAN
    agari.jikaze = NAN
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.bakazepei?(tehai, agari)
      assert_equal false, @judger.jikazepei?(tehai, agari)
    end
  end
  
  def test_haku
    pai_items = "j5tj5tj5tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.haku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 暗カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tr0tj5tj5tr0t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.haku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 明カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tj5tj5tj5tj5r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.haku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
  end
    
  def test_hatsu
    pai_items = "j6tj6tj6tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.hatsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 暗カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tr0tj6tj6tr0t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.hatsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 明カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tj6tj6tj6tj6r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.hatsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def test_chun
    pai_items = "j7tj7tj7tm3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chun?(tehai, nil)
    end
    
    # 暗カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tr0tj7tj7tr0t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chun?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 明カン --> true
    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tj7tj7tj7tj7r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chun?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def test_haitei
    agari = Mjparse::Kyoku.new
    
    agari.is_haitei = true
    agari.is_tsumo = true
    assert_equal true, @judger.haitei?(nil, agari)
    
    agari.is_tsumo = false
    assert_equal false, @judger.haitei?(nil, agari)
    
  end
  
  def test_houtei
    agari = Mjparse::Kyoku.new
    
    agari.is_haitei = true
    agari.is_tsumo = false
    assert_equal true, @judger.houtei?(nil, agari)
    
    agari.is_tsumo = true
    assert_equal false, @judger.houtei?(nil, agari)
 
  end
  
  def test_rinshan
    agari = Mjparse::Kyoku.new
    
    agari.is_rinshan = true
    agari.is_tsumo = true
    assert_equal true, @judger.rinshan?(nil, agari)
    
    agari.is_tsumo = false
    assert_equal false, @judger.rinshan?(nil, agari)
    
  end
  
  def test_chankan
    agari = Mjparse::Kyoku.new
    
    agari.is_chankan = true
    agari.is_tsumo = false
    assert_equal true, @judger.chankan?(nil, agari)
    
    agari.is_tsumo = true
    assert_equal false, @judger.chankan?(nil, agari)
    
  end
  
#  def test_mentsure
#    pai_items = "m3tm4ts2ts2ts3ts3ts4ts4tp9tp9tm2tj7rj7tj7t"    
#    @resolver.get_mentsu(pai_items)
#    
#    @resolver.tehai_list.each do |tehai|
#      tehai.mentsu_list.each do |mentsu|
#        mentsu.pai_list.each do |pai|
#          p pai
#        end
#      end
#    end    
#  end
  
end
