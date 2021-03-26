require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
  end

  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "edit link functional" do
    assert @user1.password_reset_token
    get edit_password_reset_url(@user1.password_reset_token)
    assert_response :success
  end

  test "send reset routes to home" do
    post password_resets_path
    assert_response :redirect
    assert_redirected_to download_url
  end
end
