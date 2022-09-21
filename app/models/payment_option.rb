class PaymentOption < ApplicationRecord
  PAYPAL = 'PAYPAL'
  VISA = 'VISA'
  STORE = 'OFFLINE-STORE'

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true

end
