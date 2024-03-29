class Receipt < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :user
  belongs_to :payment_option

  before_save :downcase_email

  validates :address, presence: true
  validates_associated :address
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  validates :contact_number, presence: true, phone: true

  def downcase_email
    email.downcase!
  end
end
