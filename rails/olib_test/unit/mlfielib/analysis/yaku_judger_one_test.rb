# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/tehai'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/yaku_judger_one'
require 'mlfielib/analysis/mentsu_resolver'

class YakuJudgerOneTest < Test::Unit::TestCase
  
  def setup
     @judger = Mlfielib::Analysis::YakuJudger.new
     @resolver = Mlfielib::Analysis::MentsuResolver.new
  end
  
  def teardown
    
  end
  
  def test_reach
    agari = Mlfielib::Analysis::Kyoku.new
    
    agari.reach_num = 0
    assert_equal false, @judger.reach?(nil, agari)
    agari.reach_num = 1
    assert_equal true, @judger.reach?(nil, agari)
  end
  
  def test_pinfu
    agari = Mlfielib::Analysis::Kyoku.new
    agari.bakaze = 'ton'
    #一番右があがり牌
    #m2tm3t p1tp2tp3t s1ts2ts3t s6ts7ts8t j2j2 m1t
    pai_items = "m2tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2tm1t"    
    @resolver.get_mentsu(pai_items)
    
    #リャンメンであがり --> true
    @resolver.tehai_list.each do |tehai|
      #m1があがり牌
      assert_equal true, @judger.pinfu?(tehai, agari)
    end
    
    #雀頭が役牌  --> false
    agari.bakaze = 'nan'
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    agari.bakaze = 'ton'
    
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new
    #カンチャンであがり --> false
    pai_items = "m1tm3tp1tp2tp3ts1ts2ts3ts6ts7ts8tj2tj2tm2t"    
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|  
      assert_equal false, @judger.pinfu?(tehai, agari)
    end
    
    
    #あんこうが存在  --> false
    
    #鳴きがある  --> false
    
    
  end
  
end