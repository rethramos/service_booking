require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  def setup
    @service = businesses(:one).services.build(
      name: 'Service 1',
      description: 'Descriptions',
      unit_price: 1500.00
    )
  end

  test 'should be valid' do
    assert @service.valid?
  end

  test 'should require name' do
    @service.name = '    '
    assert_not @service.valid?
  end

  test 'name should be unique per business' do
    copy = @service.dup
    @service.save
    assert_not copy.valid?

    copy.business = businesses(:two)
    assert copy.valid?
  end

  test 'name should be at most 100 characters' do
    @service.name = 'a' * 101
    assert_not @service.valid?
  end

  test 'service category must belong to the same business' do
    @service.service_category = service_categories(:three)
    assert_not @service.valid?

    @service.service_category = service_categories(:one)
    assert @service.valid?
  end

  test 'should require description' do
    @service.description = '    '
    assert_not @service.valid?
  end

  test 'description should be at most 500 characters' do
    @service.description = 'a' * 501
    assert_not @service.valid?
  end

  test 'should require unit price' do
    @service.unit_price = '    '
    assert_not @service.valid?
  end

  test 'unit price should be numeric' do
    @service.unit_price = '10O'
    assert_not @service.valid?
  end

  test 'unit price should be non-negative' do
    @service.unit_price = -0.01
    assert_not @service.valid?
  end

  test 'should require currency' do
    @service.currency = '    '
    assert_not @service.valid?
  end

  test 'currency should be at most 3 characters' do
    @service.currency = 'USDS'
    assert_not @service.valid?
  end

  test 'currency should be in uppercase' do
    @service.currency = 'usd'
    @service.save
    assert @service.currency = 'USD'
  end
end
