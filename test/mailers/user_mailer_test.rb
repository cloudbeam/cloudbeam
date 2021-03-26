require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end

  test "password_reset" do
    mail = UserMailer.password_reset(@user)
    assert_equal "Password Reset", mail.subject
    assert_equal ["vontest@example.com"], mail.to
    assert_equal ["teamcloudbeam@cloud-beam.com"], mail.from
    assert_match(/To reset your CloudBeam password/, mail.body.encoded)
  end

end
