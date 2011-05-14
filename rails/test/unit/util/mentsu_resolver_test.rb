require 'test_helper'

class MentsuResolverTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do
    agari = Agari.new
    agari.is_tsumo = false
    agari.is_parent = true
    agari.tehai_list = 'm3m3m3m4m4m4m6m6m6p1p1m5m5m5'
    
    Mjt::Analysis::TeyakuDecider.get_agari_teyaku(agari)
    
    p agari
    
    end
end
