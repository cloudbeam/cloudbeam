require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post login_url, params: { name: @user.email, password: 'password' }

    @document = documents(:one)
  end

  test "should get index" do
    get documents_url
    assert_response :success
  end

  test "should get new" do
    skip
    get new_document_url
    assert_response :success
  end

  test "should create document" do
    skip
    assert_difference('Document.count') do
      post documents_url, params: { document: { expired_at: @document.expired_at, name: @document.name, uploaded_at: @document.uploaded_at, url: @document.url, user_id: @document.user_id } }
    end

    assert_redirected_to document_url(Document.last)
  end

  test "should show document" do
    skip
    get document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    skip
    get edit_document_url(@document)
    assert_response :success
  end

  test "should update document" do
    skip
    patch document_url(@document), params: { document: { expired_at: @document.expired_at, name: @document.name, uploaded_at: @document.uploaded_at, url: @document.url, user_id: @document.user_id } }
    assert_redirected_to document_url(@document)
  end

  test "should destroy document" do
    skip
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
