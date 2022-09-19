class ServiceCategory < ApplicationRecord
  belongs_to :business
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :image, presence: true, content_type: {
    in: %w[image/jpeg image/png],
    message: 'must be a valid image format'
  }, size: {
    less_than: 5.megabytes,
    message: 'should be less than 5MB'
  }
end
