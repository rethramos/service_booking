require 'test_helper'

class ServiceCategoryTest < ActiveSupport::TestCase
  def setup
    @service_category = businesses(:one).service_categories.build(
      name: 'Hair',
      description: 'Hair services'
    )
    filename = 'kitten.jpg'
    @service_category.image.attach(
      io: File.open(
        Rails.root.join('test', 'fixtures', 'files', filename)
      ),
      filename:,
      content_type: 'image/jpeg'
    )
  end

  test 'should be valid' do
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
