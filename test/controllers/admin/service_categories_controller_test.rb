require "test_helper"

class Admin::ServiceCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_admin_service_category_path
    assert_redirected_to admin_login_url
  end

  test "should get create" do
    post admin_service_categories_path
    assert_redirected_to admin_login_url
  end

  # test "should get index" do
  #   get admin_service_categories_index_url
  #   assert_response :success
  # end

  # test "should get show" do
  #   get admin_service_categories_show_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get admin_service_categories_edit_url
  #   assert_response :success
  # end

  # test "should get update" do
  #   get admin_service_categories_update_url
  #   assert_response :success
  # end
end
