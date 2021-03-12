require 'test_helper'

class RakeTest < ActiveSupport::TestCase
  setup do 
    CloudBeam::Application.load_tasks
  end


  test "verify expired documents were deleted" do
    assert_equal(5, documents.size)
    Rake::Task['expired:remove_expired'].invoke
    assert_equal(2, documents.size)
  end
  # test "check total number of show_expired" do
  #   # assert Rake::Task['expired:show_expired']
  #   expired = Rake::Task['expired:show_expired'].invoke
  #   puts expired
  #   assert_equal(3, expired)
  # end
end