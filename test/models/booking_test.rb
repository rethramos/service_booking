require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  def setup
    service = services(:one)
    @booking = receipts(:one).bookings.build(
      service:,
      booking_status: booking_statuses(:one),
      service_name: service.name,
      service_appointment: service.appointments.first.timeslot,
      service_unit_price: service.unit_price,
      service_currency: service.currency,
      slots: cart_items(:one).slots
    )
  end

  test 'should be valid' do
    assert @booking.valid?
  end

  test 'should require receipt' do
    @booking.receipt = nil
    assert_not @booking.valid?
  end

  test 'should require service name' do
    @booking.service_name = nil
    assert_not @booking.valid?
  end

  test 'name should be at most 100 characters' do
    @booking.service_name = 'a' * 101
    assert_not @booking.valid?
  end

  test 'should require unit price' do
    @booking.service_unit_price = '    '
    assert_not @booking.valid?
  end

  test 'unit price should be numeric' do
    @booking.service_unit_price = '10O'
    assert_not @booking.valid?
  end

  test 'unit price should be non-negative' do
    @booking.service_unit_price = -0.01
    assert_not @booking.valid?
  end

  test 'should require currency' do
    @booking.service_currency = '    '
    assert_not @booking.valid?
  end

  test 'currency should be at most 3 characters' do
    @booking.service_currency = 'USDS'
    assert_not @booking.valid?
  end

  test 'currency should be in uppercase' do
    @booking.service_currency = 'usd'
    @booking.save
    assert @booking.reload.service_currency == 'USD'
  end

  test 'should require slots' do
    @booking.slots = '   '
    assert_not @booking.valid?
  end

  test 'slots should be numeric' do
    @booking.slots = '5a'
    assert_not @booking.valid?
  end

  test 'addon should be at most 300 characters' do
    @booking.addon = 'a' * 301
    assert_not @booking.valid?
  end
end
