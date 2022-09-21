class Appointment < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :service

  validates :timeslot, presence: true, uniqueness: { scope: :service_id }
  validates :max_slots, presence: true, numericality: { greater_than: 0 }
  validate :future_timeslot, unless: proc { |a| a.timeslot.blank? }

  def future_timeslot
    if timeslot < 3.days.from_now
      message = 'must be at least 3 days from now'
      errors.add :timeslot, message
    end
  end
end
