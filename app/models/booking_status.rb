class BookingStatus < ApplicationRecord
  PENDING = 'PENDING'
  CANCELLED = 'CANCELLED'
  SERVED = 'SERVED'

  has_many :bookings, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true

  def self.pending
    BookingStatus.find_by(name: PENDING)
  end

  def self.cancelled
    BookingStatus.find_by(name: CANCELLED)
  end

  def self.served
    BookingStatus.find_by(name: SERVED)
  end
end
