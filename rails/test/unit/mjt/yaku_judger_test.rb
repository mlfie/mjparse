require 'test_helper'

class YakuJudgerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do

    agari = Agari.new

#    agari.tehai_list="m1m2m3m4m5m6m7m8m9p1p2p3p4p4" # pinfu
    # pinfu
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('m1', false, false)
    pai02 = Mjt::Analysis::Pai.new('m2', false, false)
    pai03 = Mjt::Analysis::Pai.new('m3', false, false)
    pai04 = Mjt::Analysis::Pai.new('m4', false, false)
    pai05 = Mjt::Analysis::Pai.new('m5', false, false)
    pai06 = Mjt::Analysis::Pai.new('m6', false, false)
    pai07 = Mjt::Analysis::Pai.new('m7', false, false)
    pai08 = Mjt::Analysis::Pai.new('m8', false, false)
    pai09 = Mjt::Analysis::Pai.new('m9', false, false)
    pai10 = Mjt::Analysis::Pai.new('p1', false, false)
    pai11 = Mjt::Analysis::Pai.new('p2', false, false)
    pai12 = Mjt::Analysis::Pai.new('p3', false, false)
    pai13 = Mjt::Analysis::Pai.new('p4', false, false)
    pai14 = Mjt::Analysis::Pai.new('p4', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="m2m2m2p2p3p4p5p6p7p6p7p8m8m8" # tanyao
    # tanyao
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('m2', false, false)
    pai02 = Mjt::Analysis::Pai.new('m2', false, false)
    pai03 = Mjt::Analysis::Pai.new('m2', false, false)
    pai04 = Mjt::Analysis::Pai.new('p2', false, false)
    pai05 = Mjt::Analysis::Pai.new('p3', false, false)
    pai06 = Mjt::Analysis::Pai.new('p4', false, false)
    pai07 = Mjt::Analysis::Pai.new('p5', false, false)
    pai08 = Mjt::Analysis::Pai.new('p6', false, false)
    pai09 = Mjt::Analysis::Pai.new('p7', false, false)
    pai10 = Mjt::Analysis::Pai.new('p6', false, false)
    pai11 = Mjt::Analysis::Pai.new('p7', false, false)
    pai12 = Mjt::Analysis::Pai.new('p8', false, false)
    pai13 = Mjt::Analysis::Pai.new('m8', false, false)
    pai14 = Mjt::Analysis::Pai.new('m8', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="m2m2m2p2p2p3p3p4p4p6p7p8m8m8" # tanyao ipeiko
    # tanyao ipeiko
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('m2', false, false)
    pai02 = Mjt::Analysis::Pai.new('m2', false, false)
    pai03 = Mjt::Analysis::Pai.new('m2', false, false)
    pai04 = Mjt::Analysis::Pai.new('p2', false, false)
    pai05 = Mjt::Analysis::Pai.new('p2', false, false)
    pai06 = Mjt::Analysis::Pai.new('p3', false, false)
    pai07 = Mjt::Analysis::Pai.new('p3', false, false)
    pai08 = Mjt::Analysis::Pai.new('p4', false, false)
    pai09 = Mjt::Analysis::Pai.new('p4', false, false)
    pai10 = Mjt::Analysis::Pai.new('p6', false, false)
    pai11 = Mjt::Analysis::Pai.new('p7', false, false)
    pai12 = Mjt::Analysis::Pai.new('p8', false, false)
    pai13 = Mjt::Analysis::Pai.new('m8', false, false)
    pai14 = Mjt::Analysis::Pai.new('m8', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="m2m2p1p2p2p3p3p4j6j6j6m1m1m1" # hatsu
    # hatsu
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('m2', false, false)
    pai02 = Mjt::Analysis::Pai.new('m2', false, false)
    pai03 = Mjt::Analysis::Pai.new('p1', false, false)
    pai04 = Mjt::Analysis::Pai.new('p2', false, false)
    pai05 = Mjt::Analysis::Pai.new('p2', false, false)
    pai06 = Mjt::Analysis::Pai.new('p3', false, false)
    pai07 = Mjt::Analysis::Pai.new('p3', false, false)
    pai08 = Mjt::Analysis::Pai.new('p4', false, false)
    pai09 = Mjt::Analysis::Pai.new('j6', false, false)
    pai10 = Mjt::Analysis::Pai.new('j6', false, false)
    pai11 = Mjt::Analysis::Pai.new('j6', false, false)
    pai12 = Mjt::Analysis::Pai.new('m1', false, false)
    pai13 = Mjt::Analysis::Pai.new('m1', false, false)
    pai14 = Mjt::Analysis::Pai.new('m1', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="j1j1j1j2j2j2j7j7j7m1m2m3p3p3" # chun nan ton
    # chun nan ton
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('j1', false, false)
    pai02 = Mjt::Analysis::Pai.new('j1', false, false)
    pai03 = Mjt::Analysis::Pai.new('j1', false, false)
    pai04 = Mjt::Analysis::Pai.new('j2', false, false)
    pai05 = Mjt::Analysis::Pai.new('j2', false, false)
    pai06 = Mjt::Analysis::Pai.new('j2', false, false)
    pai07 = Mjt::Analysis::Pai.new('j7', false, false)
    pai08 = Mjt::Analysis::Pai.new('j7', false, false)
    pai09 = Mjt::Analysis::Pai.new('j7', false, false)
    pai10 = Mjt::Analysis::Pai.new('m1', false, false)
    pai11 = Mjt::Analysis::Pai.new('m2', false, false)
    pai12 = Mjt::Analysis::Pai.new('m3', false, false)
    pai13 = Mjt::Analysis::Pai.new('p3', false, false)
    pai14 = Mjt::Analysis::Pai.new('p3', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="p1p2p3m1m2m3p1p2p3p1p2p3p9p9" # 3shoku ipeiko zyunchan
    # 3shoku ipeiko zyunchan
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('p1', false, false)
    pai02 = Mjt::Analysis::Pai.new('p2', false, false)
    pai03 = Mjt::Analysis::Pai.new('p3', false, false)
    pai04 = Mjt::Analysis::Pai.new('m1', false, false)
    pai05 = Mjt::Analysis::Pai.new('m2', false, false)
    pai06 = Mjt::Analysis::Pai.new('m3', false, false)
    pai07 = Mjt::Analysis::Pai.new('p1', false, false)
    pai08 = Mjt::Analysis::Pai.new('p2', false, false)
    pai09 = Mjt::Analysis::Pai.new('p3', false, false)
    pai10 = Mjt::Analysis::Pai.new('p1', false, false)
    pai11 = Mjt::Analysis::Pai.new('p2', false, false)
    pai12 = Mjt::Analysis::Pai.new('p3', false, false)
    pai13 = Mjt::Analysis::Pai.new('p9', false, false)
    pai14 = Mjt::Analysis::Pai.new('p9', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14

    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

#    agari.tehai_list="p1p2p3p1p2p3p1p2p3p1p2p3p9p9" # chinitsu
    # chinitsu
    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('p1', false, false)
    pai02 = Mjt::Analysis::Pai.new('p2', false, false)
    pai03 = Mjt::Analysis::Pai.new('p3', false, false)
    pai04 = Mjt::Analysis::Pai.new('p1', false, false)
    pai05 = Mjt::Analysis::Pai.new('p2', false, false)
    pai06 = Mjt::Analysis::Pai.new('p3', false, false)
    pai07 = Mjt::Analysis::Pai.new('p1', false, false)
    pai08 = Mjt::Analysis::Pai.new('p2', false, false)
    pai09 = Mjt::Analysis::Pai.new('p3', false, false)
    pai10 = Mjt::Analysis::Pai.new('p1', false, false)
    pai11 = Mjt::Analysis::Pai.new('p2', false, false)
    pai12 = Mjt::Analysis::Pai.new('p3', false, false)
    pai13 = Mjt::Analysis::Pai.new('p9', false, false)
    pai14 = Mjt::Analysis::Pai.new('p9', false, false)
    pai_items << pai01
    pai_items << pai02
    pai_items << pai03
    pai_items << pai04
    pai_items << pai05
    pai_items << pai06
    pai_items << pai07
    pai_items << pai08
    pai_items << pai09
    pai_items << pai10
    pai_items << pai11
    pai_items << pai12
    pai_items << pai13
    pai_items << pai14
    
    resolver = Mjt::Analysis::MentsuResolver.new
    resolver.get_mentsu(pai_items)
#    resolver.get_mentsu(agari)
    resolver.tehai_list.each do | tehai |
	 Mjt::Analysis::YakuJudger.set_yaku_list(tehai, agari)
         p tehai.yaku_list
    end

  end	
end
