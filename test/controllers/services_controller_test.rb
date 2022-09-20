require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = services(:one)
    @business = businesses(:one)
  end

  test "should get index" do
    get admin_business_services_url(@service.business)
    assert_redirected_to admin_login_url
  end

  test "should get new" do
    get new_admin_business_service_url(@business)
    assert_redirected_to admin_login_url
  end

  test "should create service" do
    assert_no_difference("Service.count") do
      post admin_business_services_url(@business), params: {
        service: {
          business_id: @business.id,
          description: @service.description,
          name: 'Another Service',
          service_category_id: @service.service_category_id,
          unit_price: @service.unit_price
        }
      }
    end

    assert_redirected_to admin_login_url
  end

  test "should show service" do
    get admin_business_service_path(@service.business_id, @service)
    assert_redirected_to admin_login_url
  end

  test "should get edit" do
    get edit_admin_business_service_url(@service.business, @service)
    assert_redirected_to admin_login_url
  end

  test "should update service" do
    patch admin_business_service_path(@service.business, @service), params: {
      service: {
        business_id: @service.business_id,
        description: @service.description,
        name: @service.name,
        service_category_id:
        @service.service_category_id,
        unit_price: @service.unit_price
        }
    }
    assert_redirected_to admin_login_url
  end

  test "should destroy service" do
    assert_no_difference("Service.count") do
      delete admin_business_service_path(@service.business, @service)
    end

    assert_redirected_to admin_login_url
  end
end
