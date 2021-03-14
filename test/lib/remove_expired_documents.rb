require 'test_helper'

class RakeTest < ActiveSupport::TestCase
  setup do 
    CloudBeam::Application.load_tasks
  end


  test "verify expired documents were deleted" do
    assert_equal(5, Document.count)
    assert_difference('Document.count', -3) do
      Rake::Task['expired:remove_expired'].invoke
    end
  end
end