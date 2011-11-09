require 'test_helper'

class AgarisControllerTest < ActionController::TestCase
  test "create new agari" do
    agari = Hash.new
    agari["img_url"] = 'http://mjt.fedc.biz/img/2.jpg'
    agari["bakaze"] = :ton
    agari["jikaze"] = :ton

    assert_difference('Agari.count') do
      post :create, :agari => agari, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]
    assert_equal result["tehai_list"], "p1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6tj7tj7rj7t"
    assert_equal result["status_code"], 200
    assert_equal result["total_fu_num"], 30
    assert_equal result["total_han_num"], 3
    assert_equal result["total_point"], 3900

  end
end
