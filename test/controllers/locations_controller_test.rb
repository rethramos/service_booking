require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get countries" do
    get locations_countries_url
    assert_response :success
  end

  test "should get states" do
    get locations_states_url
    assert_response :success
  end

  test "should get cities" do
    get locations_cities_url
    assert_response :success
  end
end
