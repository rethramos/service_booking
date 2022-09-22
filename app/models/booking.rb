class Booking < ApplicationRecord
  belongs_to :receipt
  belongs_to :service
  belongs_to :booking_status

  before_validation :upcase_currency

  validates :service_name, presence: true, length: { maximum: 100 }
  validates :service_unit_price, presence: true,
                                 numericality: { greater_than_or_equal_to: 0.00 }
  validates :service_currency, presence: true, length: { maximum: 3 }
  validates :slots, presence: true, numericality: { greater_than: 0 }
  validates :addon, length: { maximum: 300 }
  validate :free_slots, unless: proc { |b| b.service.nil? || b.service_appointment.blank? || b.slots.blank? }

  private

  def upcase_currency
    service_currency.upcase! unless service_currency.nil?
  end

  def free_slots
    sum_taken = service.bookings.where(service_appointment:).sum(:slots)
    max_slots = service.appointments.find_by(timeslot: service_appointment).max_slots

    if sum_taken + slots > max_slots
      message = 'must not exceed the remaining slots'
      errors.add :slots, message
    end
  end
end
