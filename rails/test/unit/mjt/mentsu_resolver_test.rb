require 'test_helper'

class MentsuResolverTest < ActiveSupport::TestCase  
  test "menzen shuntsu nomi" do
    resolver = Mjt::Analysis::MentsuResolver.new

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
    pai13 = Mjt::Analysis::Pai.new('j1', false, false)
    pai14 = Mjt::Analysis::Pai.new('j1', false, false)
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
    
    resolver.get_mentsu(pai_items)
    
    assert_equal resolver.tehai_list.size, 1
  end

  test "menzen koutsu nomi" do
    resolver = Mjt::Analysis::MentsuResolver.new

    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('j1', false, false)
    pai02 = Mjt::Analysis::Pai.new('j1', false, false)
    pai03 = Mjt::Analysis::Pai.new('j1', false, false)
    pai04 = Mjt::Analysis::Pai.new('j2', false, false)
    pai05 = Mjt::Analysis::Pai.new('j2', false, false)
    pai06 = Mjt::Analysis::Pai.new('j2', false, false)
    pai07 = Mjt::Analysis::Pai.new('j3', false, false)
    pai08 = Mjt::Analysis::Pai.new('j3', false, false)
    pai09 = Mjt::Analysis::Pai.new('j3', false, false)
    pai10 = Mjt::Analysis::Pai.new('j4', false, false)
    pai11 = Mjt::Analysis::Pai.new('j4', false, false)
    pai12 = Mjt::Analysis::Pai.new('j4', false, false)
    pai13 = Mjt::Analysis::Pai.new('j5', false, false)
    pai14 = Mjt::Analysis::Pai.new('j5', false, false)
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
    
    resolver.get_mentsu(pai_items)
    
    assert_equal resolver.tehai_list.size, 1
  end

  test "menzen shuntsu koutsu" do
    resolver = Mjt::Analysis::MentsuResolver.new

    pai_items = Array.new
    pai01 = Mjt::Analysis::Pai.new('m1', false, false)
    pai02 = Mjt::Analysis::Pai.new('m2', false, false)
    pai03 = Mjt::Analysis::Pai.new('m3', false, false)
    pai04 = Mjt::Analysis::Pai.new('j2', false, false)
    pai05 = Mjt::Analysis::Pai.new('j2', false, false)
    pai06 = Mjt::Analysis::Pai.new('j2', false, false)
    pai07 = Mjt::Analysis::Pai.new('p1', false, false)
    pai08 = Mjt::Analysis::Pai.new('p2', false, false)
    pai09 = Mjt::Analysis::Pai.new('p3', false, false)
    pai10 = Mjt::Analysis::Pai.new('j4', false, false)
    pai11 = Mjt::Analysis::Pai.new('j4', false, false)
    pai12 = Mjt::Analysis::Pai.new('j4', false, false)
    pai13 = Mjt::Analysis::Pai.new('j5', false, false)
    pai14 = Mjt::Analysis::Pai.new('j5', false, false)
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
    
    resolver.get_mentsu(pai_items)
    
    assert_equal resolver.tehai_list.size, 1
  end

end
