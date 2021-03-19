require 'test_helper'

class RakeTest < ActiveSupport::TestCase
  setup do 
    CloudBeam::Application.load_tasks
  end
  test "verify old documents and doc_rec were removed" do
    assert_equal(5, Document.count)
    assert_difference -> {Document.count} => -3, ->{DocumentRecipient.count} => -3 do
      Rake::Task['expired:remove_old'].invoke
    end
  end

  test "verify expired documents and doc_rec were deleted" do
    assert_equal(5, Document.count)
    assert_difference -> {Document.count} => -1, ->{DocumentRecipient.count} => -2 do
      Rake::Task['expired:remove_expired'].invoke
    end
  end 
end