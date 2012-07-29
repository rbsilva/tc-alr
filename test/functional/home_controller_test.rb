require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.first
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
