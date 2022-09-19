class Service < ApplicationRecord
  belongs_to :business
  belongs_to :service_category, optional: true

  before_validation :upcase_currency

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :unit_price, presence: true,
                         numericality: { greater_than_or_equal_to: 0.00 }
  validates :currency, presence: true, length: { maximum: 3 }

  private

  def upcase_currency
    currency.upcase
  end
end
