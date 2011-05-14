require 'test_helper'

class MentsuResolverTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "private method" do
    agari = Agari.new
    agari.tehai_list = 'm3m3m3m4m4m4m6m7m8p1p1m5m5m5'
    resolver = Mjt::Analysis::MentsuResolver.new
    
    resolver.get_mentsu(agari)
    
    p resolver.result_list
  end
end
