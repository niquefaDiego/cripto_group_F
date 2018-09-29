require 'test_helper'

class SecretsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secret = secrets(:one)
  end

  test "should get index" do
    get secrets_url
    assert_response :success
  end

  test "should get new" do
    get new_secret_url
    assert_response :success
  end

  test "should create secret" do
    assert_difference('Secret.count') do
      post secrets_url, params: { secret: { algorithm: @secret.algorithm, message: "Hello there!", key: "supersecret" } }
    end

    assert_redirected_to secret_url(Secret.last)
  end

  test "should show secret" do
    get secret_url(@secret)
    assert_response :success
  end

  test "should get edit" do
    get edit_secret_url(@secret)
    assert_response :success
  end

  test "should update secret" do
    patch secret_url(@secret), params: { secret: { algorithm: @secret.algorithm, ciphertext: @secret.ciphertext } }
    assert_redirected_to secret_url(@secret)
  end

  test "should destroy secret" do
    assert_difference('Secret.count', -1) do
      delete secret_url(@secret)
    end

    assert_redirected_to secrets_url
  end

  test "should accept valid algorithms" do
    valid_algorithms = [0,1]
    valid_algorithms.each do |valid_algorithm|
      @secret.algorithm = valid_algorithm
      assert @secret.valid?, "#{valid_algorithm} should be a valid algorithm"
    end
  end

  test "should reject invalid algorithms" do
    invalid_algorithms = [-1,2,3,4,10]
    invalid_algorithms.each do |invalid_algorithm|
      @secret.algorithm = invalid_algorithm
      assert_not @secret.valid?, "#{invalid_algorithm} should be an invalid algorithm"
    end
  end

end
