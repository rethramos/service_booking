class BookingStatus < ApplicationRecord
  PENDING = 'PENDING'
  CANCELLED = 'CANCELLED'
  SERVED = 'SERVED'

  has_many :bookings, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
