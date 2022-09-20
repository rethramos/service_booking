require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @appointment = services(:one).appointments.build(
      timeslot: 3.days.from_now,
      max_slots: 1
    )
  end

  test 'should be valid' do
    assert @appointment.valid?
  end

  test 'should require timeslot' do
    @appointment.timeslot = '    '
    assert_not @appointment.valid?
  end

  test 'timeslot should be a valid datetime string' do
    @appointment.timeslot = 'Buh'
    assert_not @appointment.valid?
  end

  test 'should require max slots' do
    @appointment.max_slots = '    '
    assert_not @appointment.valid?
  end

  test 'max slots should be numeric' do
    @appointment.max_slots = 'a'
    assert_not @appointment.valid?
  end

  test 'max slots should be positive' do
    invalid_values = [0, -1]
    invalid_values.each do |v|
      @appointment.max_slots = v
      assert_not @appointment.valid?
    end
  end
end
