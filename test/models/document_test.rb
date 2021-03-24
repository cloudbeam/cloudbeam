require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  setup do
    @document1 = documents(:one)
    @document2 = documents(:two)
    @document3 = documents(:three)
    @document4 = documents(:four)
  end

  test "redundant_filenames retrieves correct number" do
    file_name = @document3.name
    regex = "#{file_name}"
    total_redundant_names = @document1.redundant_filenames(1, regex)
    assert_equal 2, total_redundant_names
  end
 
  test "redundant_filenames retrieves no existing filenames" do
    file_name = "New File Name"
    regex = "#{file_name}"
    total_redundant_names = @document1.redundant_filenames(1, regex)
    assert_equal 0, total_redundant_names
  end

  test "append_counter_if_redundant_name sets new name" do
    redundant_name = @document3.name
    assert_equal "test-doc-3", @document4.name
    @document4.append_counter_if_redundant_name(@document4.user_id, redundant_name)
    assert_equal "test-doc-3(1)", @document4.name
    assert_not_equal "test-doc-4", @document4.name
  end

  test "append_counter_if_redundant_name does not add to unique" do
    unique_name = "New File Name"
    assert_equal "test-doc-1", @document1.name
    @document1.append_counter_if_redundant_name(@document1.user_id, unique_name)
    assert_equal "test-doc-1", @document1.name
  end
end
