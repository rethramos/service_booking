class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :service
  belongs_to :appointment

  validates :service_id, uniqueness: { scope: [:cart_id, :appointment_id] }
  validates :addon, length: { maximum: 300 }
  validates :slots, presence: true, numericality: { greater_than: 0 }
  validate :slots_do_not_exceed_the_maximum,
           unless: proc { |i| i.appointment.nil? || i.slots.blank? }
  validate :future_appointment, unless: proc { |i| i.appointment.nil? }
  validate :appointment_belongs_to_service, unless: proc { |i| i.appointment.nil? || i.service.nil? }

  private

  # TODO: check existing slots later when booking model is ready
  def slots_do_not_exceed_the_maximum
    if slots > appointment.max_slots
      message = 'must not exceed the maximum for the given appointment'
      errors.add :slots, message
    end
  end

  def future_appointment
    if appointment.timeslot < 3.days.from_now
      message = 'must be at least 3 days from now'
      errors.add :appointment, message
    end
  end

  def appointment_belongs_to_service
    errors.add :appointment, 'must belong to the same service' if appointment.service_id != service_id
  end
end
