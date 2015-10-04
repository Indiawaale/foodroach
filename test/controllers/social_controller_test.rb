require 'test_helper'

class SocialControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get notify" do
    get :notify
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
