require 'test_helper'

class Admin::DataTablesControllerTest < ActionController::TestCase
  setup do
    @admin_data_table = admin_data_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_data_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_data_table" do
    assert_difference('Admin::DataTable.count') do
      post :create, admin_data_table: @admin_data_table.attributes
    end

    assert_redirected_to admin_data_table_path(assigns(:admin_data_table))
  end

  test "should show admin_data_table" do
    get :show, id: @admin_data_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_data_table
    assert_response :success
  end

  test "should update admin_data_table" do
    put :update, id: @admin_data_table, admin_data_table: @admin_data_table.attributes
    assert_redirected_to admin_data_table_path(assigns(:admin_data_table))
  end

  test "should destroy admin_data_table" do
    assert_difference('Admin::DataTable.count', -1) do
      delete :destroy, id: @admin_data_table
    end

    assert_redirected_to admin_data_tables_path
  end
end
