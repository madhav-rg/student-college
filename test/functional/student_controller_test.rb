require 'test_helper'

class StudentControllerTest < ActionController::TestCase
  test "should get do_queries" do
    get :do_queries
    assert_response :success
  end

end
