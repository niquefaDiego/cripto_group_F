require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { 
        name: " \t ",
        email: "invalid@",
        password: "123",
        password_confirmation: "321" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'

  end

  test "valid signup information" do

    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end

  end

end

