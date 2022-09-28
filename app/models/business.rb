class Business < ApplicationRecord
  belongs_to :user
  has_one :address, as: :addressable, dependent: :destroy
  has_many :service_categories, dependent: :destroy
  has_many :services, dependent: :destroy

  accepts_nested_attributes_for :address
  validates :name, presence: true, length: { maximum: 100 }
  validates :timezone, presence: true
  validate :timezone_exists

  private

  def timezone_exists
    return if timezone? && ActiveSupport::TimeZone[timezone].present?

    errors.add(:timezone, 'is not supported')
  end
end
