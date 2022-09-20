require "test_helper"

class Admin::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_admin_appointment_path
    assert_redirected_to admin_login_url
  end

  test "should get create" do
    post admin_appointments_path
    assert_redirected_to admin_login_url
  end
end
