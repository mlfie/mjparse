require 'test_helper'

class AgarisControllerTest < ActionController::TestCase
  setup do
    @agari = agaris(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agaris)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agari" do
    assert_difference('Agari.count') do
      post :create, :agari => @agari.attributes
    end

    assert_redirected_to agari_path(assigns(:agari))
  end

  test "should show agari" do
    get :show, :id => @agari.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @agari.to_param
    assert_response :success
  end

  test "should update agari" do
    put :update, :id => @agari.to_param, :agari => @agari.attributes
    assert_redirected_to agari_path(assigns(:agari))
  end

  test "should destroy agari" do
    assert_difference('Agari.count', -1) do
      delete :destroy, :id => @agari.to_param
    end

    assert_redirected_to agaris_path
  end
end
