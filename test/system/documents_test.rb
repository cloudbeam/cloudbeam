require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  setup do
    @document = documents(:one)
  end

  test "visiting the index" do
    visit documents_url
    assert_selector "h1", text: "Documents"
  end

  test "creating a Document" do
    visit documents_url
    click_on "New Document"

    fill_in "Expired at", with: @document.expired_at
    fill_in "Name", with: @document.name
    fill_in "Uploaded at", with: @document.uploaded_at
    fill_in "Url", with: @document.url
    fill_in "User", with: @document.user_id
    click_on "Create Document"

    assert_text "Document was successfully created"
    click_on "Back"
  end

  test "updating a Document" do
    visit documents_url
    click_on "Edit", match: :first

    fill_in "Expired at", with: @document.expired_at
    fill_in "Name", with: @document.name
    fill_in "Uploaded at", with: @document.uploaded_at
    fill_in "Url", with: @document.url
    fill_in "User", with: @document.user_id
    click_on "Update Document"

    assert_text "Document was successfully updated"
    click_on "Back"
  end

  test "destroying a Document" do
    visit documents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Document was successfully destroyed"
  end

  test "should create document" do
    assert_difference('Document.count') do
      test_doc = fixture_file_upload('files/upload-tester.json', 'application/json')

      post documents_url, params: { document: { name: 'test-doc-1', upload: test_doc, user_id: 1 } }
    end

    assert_redirected_to document_url(Document.last)
  end
end
