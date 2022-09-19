require "test_helper"

class ServiceCategoryTest < ActiveSupport::TestCase
  def setup
    @service_category = ServiceCategory.new(
      name: 'Hair',
      description: 'Hair services'
    )
  end

  test "should be valid" do
    assert @service_category.valid?
  end

  test 'should require name' do
    @service_category.name = '   '
    assert_not @service_category.valid?
  end

  test 'name should be at most 50 characters' do
    @service_category.name = 'a' * 51
    assert_not @service_category.valid?
  end

  test 'should require description' do
    @service_category.description = '    '
    assert_not @service_category.valid?
  end

  test 'description should be at most 100 characters' do
    @service_category.description = 'a' * 101
    assert_not @service_category.valid?
  end
end
