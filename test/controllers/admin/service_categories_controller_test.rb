require 'test_helper'

class Admin::ServiceCategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @service_category = service_categories(:one)
  end

  test 'should redirect new to admin login for guests' do
    get new_admin_business_service_category_path(businesses(:one))
    assert_redirected_to admin_login_url
  end

  test 'should redirect create to admin login for guests' do
    post admin_business_service_categories_path(businesses(:one))
    assert_redirected_to admin_login_url
  end

  test 'should redirect edit to admin login for guests' do
    get edit_admin_service_category_path(@service_category)
    assert_redirected_to admin_login_url
  end

  test 'should redirect update to admin login for guests' do
    patch admin_service_category_path(@service_category)
    assert_redirected_to admin_login_url
  end
end
