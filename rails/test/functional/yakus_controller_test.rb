require 'test_helper'

class YakusControllerTest < ActionController::TestCase
  setup do
    @yaku = yakus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yakus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yaku" do
    assert_difference('Yaku.count') do
      post :create, :yaku => @yaku.attributes
    end

    assert_redirected_to yaku_path(assigns(:yaku))
  end

  test "should show yaku" do
    get :show, :id => @yaku.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yaku.to_param
    assert_response :success
  end

  test "should update yaku" do
    put :update, :id => @yaku.to_param, :yaku => @yaku.attributes
    assert_redirected_to yaku_path(assigns(:yaku))
  end

  test "should destroy yaku" do
    assert_difference('Yaku.count', -1) do
      delete :destroy, :id => @yaku.to_param
    end

    assert_redirected_to yakus_path
  end
end
