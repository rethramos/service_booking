class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :line_one, presence: true, length: { maximum: 100 }
  validates :line_two, presence: true, length: { maximum: 100 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :province, presence: true, length: { maximum: 100 }
  validates :country, presence: true, length: { maximum: 100 }
  validates :postal_code, presence: true, length: { maximum: 10 },
                          numericality: true
end
