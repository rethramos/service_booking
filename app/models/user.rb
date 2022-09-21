class User < ApplicationRecord
  has_secure_password

  has_many :businesses, dependent: :destroy
  has_one :cart, dependent: :destroy

  before_save :downcase_email
  after_create :create_cart!

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :timezone, presence: true
  validate :timezone_exists

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:)
  end

  private

  def timezone_exists
    return if timezone? && ActiveSupport::TimeZone[timezone].present?

    errors.add(:timezone, 'is not supported')
  end

  def downcase_email
    email.downcase!
  end
end
