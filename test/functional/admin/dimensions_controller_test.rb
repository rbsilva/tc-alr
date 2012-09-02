require 'test_helper'

class Admin::DimensionsControllerTest < ActionController::TestCase
  setup do
    @admin_dimension = admin_dimensions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_dimensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_dimension" do
    assert_difference('Admin::Dimension.count') do
      post :create, admin_dimension: @admin_dimension.attributes
    end

    assert_redirected_to admin_dimension_path(assigns(:admin_dimension))
  end

  test "should show admin_dimension" do
    get :show, id: @admin_dimension
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_dimension
    assert_response :success
  end

  test "should update admin_dimension" do
    put :update, id: @admin_dimension, admin_dimension: @admin_dimension.attributes
    assert_redirected_to admin_dimension_path(assigns(:admin_dimension))
  end

  test "should destroy admin_dimension" do
    assert_difference('Admin::Dimension.count', -1) do
      delete :destroy, id: @admin_dimension
    end

    assert_redirected_to admin_dimensions_path
  end
end
