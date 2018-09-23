require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get des" do
    get des_path
    assert_response :success
  end

end
