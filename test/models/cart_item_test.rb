require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  def setup
    @cart_item = carts(:one).cart_items.build(
      service: services(:one),
      appointment: appointments(:three),
      slots: 1
    )
  end

  test 'should be valid' do
    assert @cart_item.valid?
  end

  test 'should require cart' do
    @cart_item.cart = nil
    assert_not @cart_item.valid?
  end

  test 'should require service' do
    @cart_item.service = nil
    assert_not @cart_item.valid?
  end

  test 'should require appointment' do
    @cart_item.appointment = nil
    assert_not @cart_item.valid?
  end

  test 'appointment should belong to the same service' do
    @cart_item.service = services(:two)
    assert_not @cart_item.valid?
  end

  test 'addon should be at most 300 characters' do
    @cart_item.addon = 'a' * 301
    assert_not @cart_item.valid?
  end

  test 'should require slots' do
    @cart_item.slots = '    '
    assert_not @cart_item.valid?
  end

  test 'slots should be a number' do
    @cart_item.slots = '5a'
    assert_not @cart_item.valid?
  end

  test 'slots should not exceed the maximum' do
    max = @cart_item.appointment.max_slots
    @cart_item.slots = max + 1
    assert_not @cart_item.valid?
  end
end
