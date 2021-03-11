require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_url
    assert_response :success
  end

  test "should logout" do
    delete logout_url
    assert_response :redirect
    assert_redirected_to download_url
  end

end
