# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/tehai'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/yaku_judger_man'
require 'mlfielib/analysis/mentsu_resolver'

class YakuJudgerManTest < Test::Unit::TestCase
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
  
  def test_kokushi
    # 13面待ち --> true
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj2tj3tj4tj5tj6tj7tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    
    # 頭が東 --> true
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj1tj2tj3tj4tj5tj6tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    
    # 頭が中帳牌 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tm5tm5tj2tj3tj4tj5tj6tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    
    # 東が暗刻 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj1tj2tj3tj4tj5tj6tj1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.kokushi?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
  end
  
  def test_tsuiso
    # 東東東西西西白白白発発発中中 --> true
    pai_items = "j1tj1tj1tj3tj3tj3tj5tj5tj5tj6tj6tj6tj7tj7t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.tsuiso?(tehai, nil)
    end
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    
    # 国士無双 --> false
    pai_items = "m1tm9tp1tp9ts1ts9tj1tj2tj3tj4tj5tj6tj7tm1t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.tsuiso?(tehai, nil)
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