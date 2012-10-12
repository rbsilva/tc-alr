require 'test_helper'

class Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    @admin_report = admin_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_report" do
    assert_difference('Admin::Report.count') do
      post :create, admin_report: @admin_report.attributes
    end

    assert_redirected_to admin_report_path(assigns(:admin_report))
  end

  test "should show admin_report" do
    get :show, id: @admin_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_report
    assert_response :success
  end

  test "should update admin_report" do
    put :update, id: @admin_report, admin_report: @admin_report.attributes
    assert_redirected_to admin_report_path(assigns(:admin_report))
  end

  test "should destroy admin_report" do
    assert_difference('Admin::Report.count', -1) do
      delete :destroy, id: @admin_report
    end

    assert_redirected_to admin_reports_path
  end
end
