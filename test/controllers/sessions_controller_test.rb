require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get session_login_url
    assert_response :success
  end

  test "should get logout" do
    get session_logout_url
    assert_response :success
  end

end
