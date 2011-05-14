require 'test_helper'

class YakuJudgerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do

    agari = Agari.new
    #agari.tehai_list="m1m2m3m4m5m6m7m8m9p1p2p3p4p4"
    #agari.tehai_list="m2m2m2p2p3p4p5p6p7p6p7p8m8m8"
    agari.tehai_list="m2m2m2p2p2p3p3p4p4p6p7p8m8m8"
    
    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(agari)
    resolver.result_list.each do | result |
	 Mjt::Analysis::YakuJudger.set_yaku_list(result, agari)
         p result.yaku_list
    end
  end	
end
