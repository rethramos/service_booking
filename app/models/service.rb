class Service < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :business
  belongs_to :service_category, optional: true
  has_one_attached :image

  before_validation :upcase_currency

  validate :category_belongs_to_the_same_business,
           unless: proc { |s| s.service_category.blank? }
  validates :name, presence: true, length: { maximum: 100 },
                   uniqueness: { scope: :business_id }
  validates :description, presence: true, length: { maximum: 500 }
  validates :unit_price, presence: true,
                         numericality: { greater_than_or_equal_to: 0.00 }
  validates :currency, presence: true, length: { maximum: 3 }
  validates :image, presence: true, content_type: {
    in: %w[image/jpeg image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }

  private

  def upcase_currency
    currency.upcase
  end

  def category_belongs_to_the_same_business
    if service_category.business != business
      message = 'Category must belong to the same business'
      errors.add :service_category, message
    end
  end
end
