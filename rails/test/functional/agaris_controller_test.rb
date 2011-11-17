require 'test_helper'

class AgarisControllerTest < ActionController::TestCase

  def yaku_include?(yaku_list,name)
    yaku_list.each do |yaku|
      return true if yaku["name"] == name
    end
    return false
  end

  # j7 j7 j7 p1 p1 p2 p2 p3 p3 p4 p4 p4 p5 p6
  img1 = "http://mjt.fedc.biz/test_img/1.jpg"
  # j7 j7(l) j7 p1 p1 p2 p2 p3 p3 p4 p4 p4 p5 p6
  img2 = "http://mjt.fedc.biz/test_img/2.jpg"
  # s4 s5 s6 p1 p1 p2 p2 p3 p3 p4 p4 p4 p5 p6
  img3 = "http://mjt.fedc.biz/test_img/3.jpg"
  # j5 j5 j5 s3 s4 s5 j7 j7 j7 j6 j6 p4 p5 p6
  img9 = "http://mjt.fedc.biz/test_img/9.jpg"
  # m6 m7 m8 p8 p7 p6 s6 s7 s8 p1 p1 p4 p5 p6
  img10 = "http://mjt.fedc.biz/test_img/10.jpg"

  test "create agari img10.1 parent ron shnshoku pinfu reache dora1" do
    request = {
      "img_url"  => img10,
      "bakaze"   => "nan",
      "jikaze"   => "ton",
      "honba_num"=> 1,
      "dora_num" => 1,
      "is_tsumo" => false,
      "is_parent"=> true,
      "reach_num"=> 1
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end

    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"m6tm7tm8tp8tp7tp6ts6ts7ts8tp1tp1tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,1
    assert_equal result["total_fu_num"] ,30
    assert_equal result["total_han_num"],4
    assert_equal result["child_point"]  ,0
    assert_equal result["parent_point"] ,0
    assert_equal result["ron_point"]    ,12300
    assert_equal result["total_point"]  ,12300

   assert_equal result["yaku_list"].size ,4
   assert yaku_include?(result["yaku_list"],"reach")
   assert yaku_include?(result["yaku_list"],"dora")
   assert yaku_include?(result["yaku_list"],"sanshoku")
   assert yaku_include?(result["yaku_list"],"pinfu")
  end

  test "create agari img10.2 child tsumo shnshoku pinfu" do
    request = {
      "img_url"  => img10,
      "bakaze"   => "nan",
      "jikaze"   => "pei",
      "honba_num"=> 0,
      "dora_num" => 0,
      "is_tsumo" => true,
      "is_parent"=> false,
      "reach_num"=> 0
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"m6tm7tm8tp8tp7tp6ts6ts7ts8tp1tp1tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,0
    assert_equal result["total_fu_num"] ,20
    assert_equal result["total_han_num"],4
    assert_equal result["child_point"]  ,1300
    assert_equal result["parent_point"] ,2600
    assert_equal result["ron_point"]    ,0
    assert_equal result["total_point"]  ,5200

    assert_equal result["yaku_list"].size ,3
    assert yaku_include?(result["yaku_list"],"tsumo")
    assert yaku_include?(result["yaku_list"],"sanshoku")
    assert yaku_include?(result["yaku_list"],"pinfu")
  end

  test "create agari img9.1 child ron shousangen honba1" do
    request = {
      "img_url"  => img9,
      "bakaze"   => "nan",
      "jikaze"   => "pei",
      "honba_num"=> 1,
      "dora_num" => 0,
      "is_tsumo" => false,
      "is_parent"=> false,
      "reach_num"=> 0
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"j5tj5tj5ts3ts4ts5tj7tj7tj7tj6tj6tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,1
    assert_equal result["total_fu_num"] ,50
    assert_equal result["total_han_num"],4
    assert_equal result["child_point"]  ,0
    assert_equal result["parent_point"] ,0
    assert_equal result["ron_point"]    ,8300
    assert_equal result["total_point"]  ,8300

    assert_equal result["yaku_list"].size ,3
    assert yaku_include?(result["yaku_list"],"chun")
    assert yaku_include?(result["yaku_list"],"haku")
    assert yaku_include?(result["yaku_list"],"shousangen")
  end

  test "create agari img3.1 child tsumo pinfu iipeikou" do
    request = {
      "img_url"  => img3,
      "bakaze"   => "ton",
      "jikaze"   => "nan",
      "honba_num"=> 0,
      "dora_num" => 0,
      "is_tsumo" => true,
      "is_parent"=> false,
      "reach_num"=> 0
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"s4ts5ts6tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,0
    assert_equal result["total_fu_num"] ,20
    assert_equal result["total_han_num"],3
    assert_equal result["child_point"]  ,700
    assert_equal result["parent_point"] ,1300
    assert_equal result["ron_point"]    ,0
    assert_equal result["total_point"]  ,2700

    assert_equal result["yaku_list"].size ,3
    assert yaku_include?(result["yaku_list"],"pinfu")
    assert yaku_include?(result["yaku_list"],"iipeikou")
    assert yaku_include?(result["yaku_list"],"tsumo")
  end


  test "create agari img1.1 parent tsumo hon0 dora0" do
    request = {
      "img_url"  => img1,
      "bakaze"   => "ton",
      "jikaze"   => "ton",
      "honba_num"=> 0,
      "dora_num" => 0,
      "is_tsumo" => true,
      "is_parent"=> true,
      "reach_num"=> 0
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"j7tj7tj7tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,1.5
    assert_equal result["total_fu_num"] ,30
    assert_equal result["total_han_num"],6
    assert_equal result["child_point"]  ,6000
    assert_equal result["parent_point"] ,0
    assert_equal result["ron_point"]    ,0
    assert_equal result["total_point"]  ,18000

    assert_equal result["yaku_list"].size ,4
    assert yaku_include?(result["yaku_list"],"chun")
    assert yaku_include?(result["yaku_list"],"honitsu")
    assert yaku_include?(result["yaku_list"],"iipeikou")
    assert yaku_include?(result["yaku_list"],"tsumo")
  end

  test "create agari img1.2 child ron hon1 dora1 reach ippatsu" do
    request = {
      "img_url"  => img1,
      "bakaze"   => "ton",
      "jikaze"   => "nan",
      "honba_num"=> 1,
      "dora_num" => 1,
      "is_tsumo" => false,
      "is_parent"=> false,
      "reach_num"=> 1,
      "is_ippatsu"=> true
    }
    assert_difference('Agari.count') do
      post :create, :agari => request, :format => 'json'
    end
    result = ActiveSupport::JSON.decode(@response.body)["agari"]

    assert_equal result["status_code"]  ,200
    assert_equal result["tehai_list"]   ,"j7tj7tj7tp1tp1tp2tp2tp3tp3tp4tp4tp4tp5tp6t"
    assert_equal result["is_furo"]      ,false
    assert_equal result["mangan_scale"] ,2
    assert_equal result["total_fu_num"] ,30
    assert_equal result["total_han_num"],8
    assert_equal result["child_point"]  ,0
    assert_equal result["parent_point"] ,0
    assert_equal result["ron_point"]    ,16000
    assert_equal result["total_point"]  ,16000

    assert_equal result["yaku_list"].size ,6
    assert yaku_include?(result["yaku_list"],"chun")
    assert yaku_include?(result["yaku_list"],"honitsu")
    assert yaku_include?(result["yaku_list"],"iipeikou")
    assert yaku_include?(result["yaku_list"],"ippatsu")
    assert yaku_include?(result["yaku_list"],"reach")
    assert yaku_include?(result["yaku_list"],"dora")
  end


end
