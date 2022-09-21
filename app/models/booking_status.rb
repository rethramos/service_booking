class BookingStatus < ApplicationRecord
  PENDING = 'PENDING'
  CANCELLED = 'CANCELLED'
  SERVED = 'SERVED'

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
