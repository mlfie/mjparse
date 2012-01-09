# -*- coding: utf-8 -*-
require 'test/unit'
require 'test_helper'
require 'mlfielib/analysis/pai'
require 'mlfielib/analysis/mentsu'
require 'mlfielib/analysis/tehai'
require 'mlfielib/analysis/kyoku'
require 'mlfielib/analysis/yaku_judger'
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
  
  def test_ryanpeikou

    # 正常系 --> true
    pai_items = "m1tm2tm3tm1tm2ts5ts6ts7ts5ts6ts7tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.ryanpeikou?(tehai, nil) unless @judger.chitoitsu?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（鳴きあり） --> false
    pai_items = "m1tm2tm3tm1tm2ts5ts6ts7tj1tj1tm3ts5ts6rs7t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryanpeikou?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（一盃口） --> false
    pai_items = "m1tm2tm3tm1tm2ts5ts6ts7ts4ts5ts6tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryanpeikou?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（三暗刻・三連刻） --> false
    pai_items = "m1tm1tm1tm2tm2tm3tm3tm3ts4ts5ts6tj1tj1tm2t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.ryanpeikou?(tehai, nil)
    end
 
  end
  
  def test_honitsu

    # 正常系 --> true
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7tm5tm6tm7tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.honitsu?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

#    # 異常系（清一色） --> false
#    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7tm5tm6tm7tm1tm1tm3t" 
#    @resolver.get_mentsu(pai_items)
#    
#    @resolver.tehai_list.each do |tehai|
#      assert_equal false, (@judger.chinitsu?(tehai, nil) && !(judger.honitsu?(tehai, nil)))
#    end
#    
#    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（他色牌あり） --> false
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7ts5ts6ts7tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.honitsu?(tehai, nil)
    end

  end
  
  def test_junchan
  
      # 正常系 --> true
    pai_items = "m1tm2tm3tm1tm2ts7ts8ts9tp7tp8tp9tm9tm9tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.junchan?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（チャンタ） --> false
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7tm5tm6tm7tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.junchan?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（4があり） --> false
    pai_items = "m2tm3tm4tm1tm2ts7ts8ts9tp7tp8tp9tm9tm9tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.junchan?(tehai, nil)
    end  
  
  end
  
  def test_chinitsu
  
    # 正常系 --> true
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7tm5tm6tm7tm1tm1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal true, @judger.chinitsu?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（混一色） --> false
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7tm5tm6tm7tj1tj1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.chinitsu?(tehai, nil)
    end
    
    @resolver = Mlfielib::Analysis::MentsuResolver.new

    # 異常系（他色牌あり） --> false
    pai_items = "m1tm2tm3tm1tm2tm5tm6tm7ts5ts6ts7tm1tm1tm3t" 
    @resolver.get_mentsu(pai_items)
    
    @resolver.tehai_list.each do |tehai|
      assert_equal false, @judger.chinitsu?(tehai, nil)
    end
  
  end
  
end
