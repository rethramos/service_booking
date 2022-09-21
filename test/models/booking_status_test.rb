require "test_helper"

class BookingStatusTest < ActiveSupport::TestCase
  def setup
    @booking_status = BookingStatus.new(
      name: 'Served'
    )
  end

  test "should be valid" do
    assert @booking_status.valid?
  end

  test "should require name" do
    @booking_status.name = '    '
    assert_not @booking_status.valid?
  end

  test "name should be at most 100 characters" do
    @booking_status.name = 'a' * 101
    assert_not @booking_status.valid?
  end

  test "name should be unique" do
    copy = @booking_status.dup
    @booking_status.save
    assert_not copy.valid?
  end
end
