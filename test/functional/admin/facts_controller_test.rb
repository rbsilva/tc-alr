require 'test_helper'

class Admin::FactsControllerTest < ActionController::TestCase
  setup do
    @admin_fact = admin_facts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_fact" do
    assert_difference('Admin::Fact.count') do
      post :create, admin_fact: @admin_fact.attributes
    end

    assert_redirected_to admin_fact_path(assigns(:admin_fact))
  end

  test "should show admin_fact" do
    get :show, id: @admin_fact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_fact
    assert_response :success
  end

  test "should update admin_fact" do
    put :update, id: @admin_fact, admin_fact: @admin_fact.attributes
    assert_redirected_to admin_fact_path(assigns(:admin_fact))
  end

  test "should destroy admin_fact" do
    assert_difference('Admin::Fact.count', -1) do
      delete :destroy, id: @admin_fact
    end

    assert_redirected_to admin_facts_path
  end
end
