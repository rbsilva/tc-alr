require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get save" do
    get :save
    assert_response :success
  end

end
