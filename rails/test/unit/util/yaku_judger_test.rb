require 'test_helper'

class YakuJudgerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do

    agari = Agari.new

    agari.tehai_list="m1m2m3m4m5m6m7m8m9p1p2p3p4p4" # pinfu

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="m2m2m2p2p3p4p5p6p7p6p7p8m8m8" # tanyao


    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="m2m2m2p2p2p3p3p4p4p6p7p8m8m8" # tanyao ipeiko

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="m2m2p1p2p2p3p3p4j6j6j6m1m1m1" # hatsu

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="j1j1j1j2j2j2j7j7j7m1m2m3p3p3" # chun nan ton
 
    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="p1p2p3m1m2m3p1p2p3p1p2p3p9p9" # 3shoku ipeiko zyunchan

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

    agari.tehai_list="p1p2p3p1p2p3p1p2p3p1p2p3p9p9" # chinitsu
    
    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end

  end	
end
