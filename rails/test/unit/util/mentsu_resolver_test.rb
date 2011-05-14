require 'test_helper'

class MentsuResolverTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do
    agari = Agari.new
    agari.is_tsumo = false
    agari.is_parent = true
    
    Mjt::Analysis::TeyakuDecider.get_agari_teyaku(agari)
    
    yaku_list = Array.new
    
    yaku1 = Yaku.new
    yaku1.kana_name = 'hoge'
    yaku_list << yaku1

    yaku2 = Yaku.new
    yaku2.kana_name = 'foo'
    yaku_list << yaku2
    
    p yaku_list
    
    agari.yaku_list = yaku_list
    
    p agari
    
    twitter = Mjt::Tsumotter.new
    twitter.update(agari)
    
  end
end
