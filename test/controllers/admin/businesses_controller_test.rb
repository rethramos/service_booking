require "test_helper"

class Admin::BusinessesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect new to admin login for guests" do
    get new_admin_business_path
    assert_redirected_to admin_login_url
  end

  test "should redirect create to admin login for guests" do
    post admin_businesses_path
    assert_redirected_to admin_login_url
  end

  test "should get index" do
    get admin_businesses_path
    assert_redirected_to admin_login_url
  end

  test "should get show" do
    get admin_businesses_path(businesses(:one))
    assert_redirected_to admin_login_url
  end
end
