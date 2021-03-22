require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  setup do
    @document1 = documents(:one)
    @document2 = documents(:two)
    @document3 = documents(:three)
  end
  # test "the truth" do
  #   assert true
  # end
  test "redundant_filenames retrieves correct number" do
    file_name = @document3.name
    regex = "#{file_name}"
    total_redundant_names = @document1.redundant_filenames(1, regex)
    assert_equal 1, total_redundant_names
  end

  test "append_counter_if_redundant_name sets new name" do
    redundant_name = @document3.name
    assert_equal "test-doc-1", @document1.name
    @document1.append_counter_if_redundant_name(@document1.user_id, redundant_name)
    assert_equal "test-doc-3(1)", @document1.name
    assert_not_equal "test-doc-1", @document1.name
  end
end
