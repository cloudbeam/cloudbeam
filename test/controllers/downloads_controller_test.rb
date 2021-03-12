require 'test_helper'

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  test "no download code provided" do
    post downloads_url, params: { download_code: '' }
    assert_equal flash[:notice], 'Please enter a code.'
    assert_redirected_to downloads_url
  end

  test "invalid download code provided" do
    post downloads_url, params: { download_code: 'foobar' }
    assert_equal flash[:notice], 'Invalid code.'
    assert_redirected_to downloads_url
  end
end
