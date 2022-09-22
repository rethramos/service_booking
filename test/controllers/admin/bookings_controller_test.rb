require "test_helper"

class Admin::BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect index to admin login for guests" do
    get admin_bookings_path
    assert_redirected_to admin_login_url
  end
end
