require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get contents" do
    get :contents
    assert_response :success
  end

end
