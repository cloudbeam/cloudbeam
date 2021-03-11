require 'test_helper'

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    post downloads_url
    assert_response :redirect
  end
end
