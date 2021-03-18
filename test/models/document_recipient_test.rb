require 'test_helper'

class DocumentRecipientTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @document = documents(:one)
    @share_info = {
        email: "valid@email.com",
        download_code: SecureRandom.uuid,
        shared_at: Time.now,
        document_id: @document.id
      }
  end

  test "create new document recipient" do 
    assert_difference('DocumentRecipient.count', +1) do
      DocumentRecipient.create!(@share_info)
    end
    assert_nothing_raised do
      DocumentRecipient.create!(@share_info)
    end
  end
  
  test "create new document recipient fail no email" do 
    assert_raise do
      @share_info.email = nil
      DocumentRecipient.create!(@share_info)
    end
  end

  test "create new document recipient fail invalid email name" do
    assert_raise do
      @share_info.email = '@blank.com'
      DocumentRecipient.create!(@share_info)
    end
  end

  test "create new document recipient fail invalid email domain" do 
    assert_raise do
      @share_info.email = 'invalid@blank.'
      DocumentRecipient.create!(@share_info)
    end
  end

  test "create new document recipient fail no download code" do 
    assert_raise do
      @share_info.download_code = nil
      DocumentRecipient.create!(@share_info)
    end
  end

  test "create new document recipient fail no shared_at" do 
    assert_raise do
      @share_info.shared_at = nil
      DocumentRecipient.create!(@share_info)
    end
  end
end
