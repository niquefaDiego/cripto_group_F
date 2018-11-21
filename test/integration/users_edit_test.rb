require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                             email: "foo@invalid",
                                             password: "foo",
                                             password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    patch user_path(@user), params: { user: { name:  name,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    patch user_path(@user), params: { user: { name:  name,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
  end

  test "no change the email" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    email = @user.email
    patch user_path(@user), params: { user: { name: @user.name,
                                             email: "newfoo@mail.com",
                                             password: "foo12345",
                                             password_confirmation: "foo12345" } }
    assert_redirected_to @user
    @user.reload
    assert_equal @user.email, email
  end

end
