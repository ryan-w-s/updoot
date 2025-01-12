require "test_helper"

class WatchersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get watchers_create_url
    assert_response :success
  end

  test "should get destroy" do
    get watchers_destroy_url
    assert_response :success
  end
end
