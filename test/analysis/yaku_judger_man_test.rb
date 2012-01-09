# -*- coding: utf-8 -*-
require 'test/unit'
require File.join(File.dirname(__FILE__), '../../lib/mjparse')

class YakuJudgerManTest < Test::Unit::TestCase
  #Constants
  TON = Mjparse::Analysis::Kyoku::KYOKU_KAZE_TON
  NAN = Mjparse::Analysis::Kyoku::KYOKU_KAZE_NAN
  SHA = Mjparse::Analysis::Kyoku::KYOKU_KAZE_SHA
  PEI = Mjparse::Analysis::Kyoku::KYOKU_KAZE_PEI
  
  def setup
    yaku_specimen = Hash.new
    # yaku_specimen[name] = Mjparse::Analysis::YakuSpecimen.new(name, kanji, han_num, naki_han_num)
    @judger = Mjparse::Analysis::YakuJudger.new(yaku_specimen)
    @resolver = Mjparse::Analysis::MentsuResolver.new
  end
  
  def teardown
    
  end
  
  def test_kokushi
    # 13面待ち --> true
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj2tj3tj4tj5tj6tj7tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
    
    # 頭が東 --> true
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj1tj2tj3tj4tj5tj6tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
    
    # 頭が中帳牌 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tm5tm5tj2tj3tj4tj5tj6tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
    
    # 東が暗刻 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj1tj2tj3tj4tj5tj6tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # 字一色7トイツ系--> false
    pai_items = "j1tj1tj2tj2tj3tj3tj4tj4tj5tj5tj6tj6tj7tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
  end

  # 四暗刻
  def test_suankou
    # m2m2m2 p4p4p4 s7s7s7 j1j1j1 j5j5 --> true
    pai_items = "m2tm2tm2tp4tp4tp4ts7ts7ts7tj1tj1tj1tj5tj5t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.suankou?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

  end

  # 大三元
  def test_daisangen
    # 白白白 発発発 中中中 m3m3m3 j1j1 --> true
    pai_items = "j5tj5tj5tj6tj6tj6tj7tj7tj7tm3tm3tm3tj1tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.daisangen?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

  end

  # 四槓子
  def test_sukantsu
    # 東東東東 m5m5m5m5 p2p2p2p2 s8s8s8s8 中中 --> true
    pai_items = "r0tj1tj1tr0tr0tm5tm5tr0tr0tp2tp2tr0tr0ts8ts8tr0tj7tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.sukantsu?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

  end

  # 天和
  # 地和

  # 大四喜
  def test_tasushi
    # 東東東南南南西西西北北北5m5m --> true
    pai_items = "j1tj1tj1tj2tj2tj2tj3tj3tj3tj4tj4tj4tm5tm5t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.tasushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

  end
  
  # 小四喜
  def test_shosushi
    # 東東東南南南西西西北北5m5m5m --> true
    pai_items = "j1tj1tj1tj2tj2tj2tj3tj3tj3tj4tj4tm5tm5tm5t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.shosushi?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
  end

  # 字一色 
  def test_tsuiso
    # 東東東西西西白白白発発発中中 --> true
    pai_items = "j1tj1tj1tj3tj3tj3tj5tj5tj5tj6tj6tj6tj7tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.tsuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
    
    # 国士無双 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj2tj3tj4tj5tj6tj7tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.tsuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
    
    # 国士無双2 --> false
    pai_items = "p1tm1tj6tm9tj1ts1ts9tj2tj3tj4tp9tj5tp1tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.tsuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
  
  end
  
  # 清老頭
  def test_chinraoto
    # m1m1m1 m9m9m9 p1p1p1 p9p9p9 s1s1 --> true
    pai_items = "m1tm1tm1tm9tm9tm9tp1tp1tp1tp9tp9tp9ts1ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chinraoto?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
  end

  # 緑一色
  def test_ryuiso
    # s2s3s4 s4s4s4 s6s6s6 s8s8s8 発発--> true
    pai_items = "s2ts3ts4ts4ts4ts4ts6ts6ts6ts8ts8ts8tj6tj6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ryuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # s2s2s2 s2s3s4 s4s4s4 s6s6s6 s8s8 -> true
    pai_items = "s2ts2ts2ts2ts3ts4ts4ts4ts4ts6ts6ts6ts8ts8t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ryuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # s2s2s2 s1s2s3 s4s4s4 s6s6s6 s8s8 -> false
    pai_items = "s2ts2ts2ts1ts2ts3ts4ts4ts4ts6ts6ts6ts8ts8t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # s2s2s2 s2s3s4 s4s4s4 s6s6s6 s9s9 -> false
    pai_items = "s2ts2ts2ts2ts3ts4ts4ts4ts4ts6ts6ts6ts9ts9t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # s2s2s2 s2s3s4 s4s4s4 s6s6s6 m8m8 -> false
    pai_items = "s2ts2ts2ts2ts3ts4ts4ts4ts4ts6ts6ts6tm8tm8t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryuiso?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new
  end

  # 九蓮宝燈
  def test_churen
    # m1m1m1m2m3m4m5m6m7m8m9m9m9 m1 --> true
    pai_items = "m1tm1tm1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.churen?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # m1m1m1m2m3m4m5m6m7m8m9m9m9 s1 --> false
    pai_items = "m1tm1tm1tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9ts1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.churen?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

    # m1m1m2m2m3m4m5m6m7m8m9m9m9 m3 --> false
    pai_items = "m1tm1tm2tm2tm3tm4tm5tm6tm7tm8tm9tm9tm9tm3t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.churen?(tehai, nil)
    end
    @resolver = Mjparse::Analysis::MentsuResolver.new

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
