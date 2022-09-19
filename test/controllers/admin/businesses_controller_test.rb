require "test_helper"

class Admin::BusinessesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_businesses_path
    assert_redirected_to admin_login_url
  end

  test "should get show" do
    get admin_businesses_path(businesses(:one))
    assert_redirected_to admin_login_url
  end
end
