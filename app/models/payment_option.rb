class PaymentOption < ApplicationRecord
  PAYPAL = 'PAYPAL'
  VISA = 'VISA'
  STORE = 'OFFLINE-STORE'

  has_many :receipts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
