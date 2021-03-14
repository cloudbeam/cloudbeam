require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post login_url, params: {user:{ email: @user.email, password: 'password' }}

    @document = documents(:one)
  end

  test "should get index" do
    get documents_url
    assert_response :success
  end

  test "index should raise error with unauthenticated user" do
    delete logout_url
    get documents_url
    assert_response :redirect
  end

  test "should get new" do
    get new_document_url
    assert_response :success
  end

  test "should show document" do
    get document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_url(@document)
    assert_response :success
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
