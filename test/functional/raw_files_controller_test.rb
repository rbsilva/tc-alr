require 'test_helper'

class RawFilesControllerTest < ActionController::TestCase
  setup do
    @raw_file = raw_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_file" do
    assert_difference('RawFile.count') do
      post :create, raw_file: @raw_file.attributes
    end

    assert_redirected_to raw_file_path(assigns(:raw_file))
  end

  test "should show raw_file" do
    get :show, id: @raw_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_file
    assert_response :success
  end

  test "should update raw_file" do
    put :update, id: @raw_file, raw_file: @raw_file.attributes
    assert_redirected_to raw_file_path(assigns(:raw_file))
  end

  test "should destroy raw_file" do
    assert_difference('RawFile.count', -1) do
      delete :destroy, id: @raw_file
    end

    assert_redirected_to raw_files_path
  end
end
