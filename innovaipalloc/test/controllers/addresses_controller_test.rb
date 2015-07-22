require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  test "should get assign" do
    get :assign
    assert_response :success
  end

end
