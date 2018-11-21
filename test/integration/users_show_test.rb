require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "show should work" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

end
