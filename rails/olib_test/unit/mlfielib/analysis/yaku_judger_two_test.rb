# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/tehai'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/yaku_judger_two'
require 'mlfielib/analysis/mentsu_resolver'

class YakuJudgerTwoTest < Test::Unit::TestCase
  #Constants
  TON = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_TON
  NAN = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_NAN
  SHA = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_SHA
  PEI = Mlfielib::Analysis::Kyoku::KYOKU_KAZE_PEI
  
  def setup
    yaku_specimen = Hash.new
    # yaku_specimen[name] = Mlfielib::Analysis::YakuSpecimen.new(name, kanji, han_num, naki_han_num)
    @judger = Mlfielib::Analysis::YakuJudger.new(yaku_specimen)
    @resolver = Mlfielib::Analysis::MentsuResolver.new
  end
  
  def teardown
    
  end
  
  def test_doublereach
    agari = Mlfielib::Analysis::Kyoku.new
    
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
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    
    # 安め --> false
    pai_items = "m1tm2tm3tp7tp8ts1ts1ts1ts7ts8ts9tj1tj1tp6t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.chanta?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
 
    # 鳴きあり --> true
    pai_items = "m1tm2tm3tp7tp8ts7ts8ts9tj2tj2tp9ts1ts1rs1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new   

    # 単キ --> true
    pai_items = "m1tm2tm3tp7tp8tp9ts1ts1ts1ts7ts8ts9tj1tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chanta?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new 

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