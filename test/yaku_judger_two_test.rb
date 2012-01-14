# -*- coding: utf-8 -*-
require 'test_helper'

class YakuJudgerTwoTest < Test::Unit::TestCase
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
  
  def test_doublereach
    agari = Mjparse::Kyoku.new
    
    agari.reach_num = 0
    assert_equal false, @judger.doublereach?(nil, agari)
    agari.reach_num = 2
    assert_equal true, @judger.doublereach?(nil, agari)
  end
  
  def test_chitoitsu
    pai_items = "m2tm2tp2tp2ts1ts1ts2ts2ts6ts6tj2tj2tj5tj5t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chitoitsu?(tehai, nil)
    end
  end
  
  def test_chanta
    pai_items = "m1tm2tm3tp7tp8ts1ts1ts1ts7ts8ts9tj1tj1tp9t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 安め --> false
    pai_items = "m1tm2tm3tp7tp8ts1ts1ts1ts7ts8ts9tj1tj1tp6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.chanta?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
 
    # 鳴きあり --> true
    pai_items = "m1tm2tm3tp7tp8ts7ts8ts9tj2tj2tp9ts1ts1rs1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new   

    # 単キ --> true
    pai_items = "m1tm2tm3tp7tp8tp9ts1ts1ts1ts7ts8ts9tj1tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new 

    # 頭だけ字牌
    pai_items = "m1tm2tm3tp7tp8tp9tp1tp1tp1ts7ts8ts9tj1tj1t"
    @resolver.get_mentsu(pai_items)
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new 

  end
  
  def test_ikkitsukan
    # マンズ --> true
    pai_items = "m1tm2tm3tm4tm5tm6tm7tm8tm9ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
    # ソウズ --> true
    pai_items = "s1ts2ts3ts4ts5ts6ts7ts8ts9ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
    # ピンズ --> true
    pai_items = "p1tp2tp3tp4tp5tp6tp7tp8tp9ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 並び順を変更 --> true
    pai_items = "p4tp5tp6tp1tp2tp3tp7tp8tp9ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # あがり牌を変更 --> true
    pai_items = "p1tp2tp3tp4tp5tp6tp7tp8ts1ts2ts3tj1tj1tp9t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 安め --> false
    pai_items = "p1tp2tp3tp4tp5tp6tp7tp8ts1ts2ts3tj1tj1tp6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # おしい形 --> false
    pai_items = "p1tp2tp3tm4tm5tm6tp7tp8ts1ts2ts3tj1tj1tp6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ikkitsukan?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
  end
  
  def test_sanshoku
    # 基本 --> true
    pai_items = "m1tm2tm3tp1tp2tp3ts1ts2ts3ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sanshoku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
    # 基本2 --> true
    pai_items = "m4tm5tm6tp4tp5tp6ts4ts5ts6ts1ts2ts3tj1tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sanshoku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
   # 安め --> false
    pai_items = "m4tm5tp4tp5tp6ts4ts5ts6ts1ts2ts3tj1tj1tm3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.sanshoku?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new

  end
  
  def test_sanshokudouko
    # 基本 --> true
    pai_items = "m1tm1tm1tp1tp1tp1ts1ts1ts1ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sanshokudouko?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # NG --> false
    pai_items = "m1tm1tm1tp2tp2tp2ts1ts1ts1ts1ts2tj1tj1ts3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.sanshokudouko?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
  end
  
  def test_toitoihou
    # 基本 --> true
    pai_items = "m1tm1tm1tp2tp2tp2ts1ts1ts1ts2ts2tj1tj1ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.toitoihou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # NG --> false
    pai_items = "m1tm1tm1tp2tp2tp2ts1ts1ts1ts1ts3tj1tj1ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.toitoihou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def test_sanankou
    # 基本 --> true
    pai_items = "m1tm1tm1tp2tp2tp2ts1ts1ts1ts1ts3tj1tj1ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sanankou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 鳴きあり --> false
    pai_items = "m1tm1tm1ts1ts1ts1ts1ts3tj1tj1ts2tp2tp2rp2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.sanankou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
  end
  
  def test_sankantsu
    # ３つ暗カン --> true
    pai_items = "s1ts3tj1tj1ts2tr0tm2tm2tr0tr0tm4tm4tr0tr0tp9tp9tr0t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sankantsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # ３つ明カン --> true
    pai_items = "s1ts3tj1tj1ts2tm2tm2tm2tm2rm4tm4tm4tm4rp9tp9tp9tp9r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sankantsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # ２つ暗カン、１つ明カン --> true
    pai_items = "s1ts3tj1tj1ts2tr0tm2tm2tr0tr0tj4tj4tr0tp9tp9tp9tp9r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sankantsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 1つ暗カン、１つ明カン --> false
    pai_items = "s1ts3tj1tj1ts2tm2tm2tm2tr0tj4tj4tr0tp9tp9tp9tp9r"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.sankantsu?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
  end
  
  def test_shousangen
    # 白白白発発発中中 --> true
    pai_items = "s1ts3tm1tm1tm1tj5tj5tj5tj6tj6tj6tj7tj7ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new

    # 白白白発発中中中 --> true
    pai_items = "s1ts3tm1tm1tm1tj5tj5tj5tj6tj6tj7tj7tj7ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 白白発発発中中中 --> true
    pai_items = "s1ts3tm1tm1tm1tj5tj5tj6tj6tj6tj7tj7tj7ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 東東東発発発中中 --> false
    pai_items = "s1ts3tm1tm1tm1tj1tj1tj1tj6tj6tj6tj7tj7ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 発発発中中 --> false
    pai_items = "s1ts3tm1tm1tm1tp5tp6tp7tj6tj6tj6tj7tj7ts2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 北北p455667発発発発中中中中 --> false
    pai_items = "j4tj4tp4tp5tp5tp6tp6tp7tr0tj6tj6tr0tr0tj7tj7tr0t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.shousangen?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  end
  
  def test_honroutou
    # 正常系 --> true
    pai_items = "s1ts1tm1tm1tm1tj5tj5tj5tj6tj6tj6tj7tj7ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.honroutou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # 頭が中張牌 --> false
    pai_items = "s1ts1tm1tm1tm1tj5tj5tj5tj6tj6tj6tm5tm5ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.honroutou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # メンツが中張牌 --> false
    pai_items = "s1ts1tm2tm2tm2tj5tj5tj5tj6tj6tj6tm1tm1ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.honroutou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
    
    # シュンツが入っている --> false
    pai_items = "s1ts1tm1tm2tm3tj5tj5tj5tj6tj6tj6tm1tm1ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.honroutou?(tehai, nil)
    end
    @resolver = Mjparse::MentsuResolver.new
  
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
