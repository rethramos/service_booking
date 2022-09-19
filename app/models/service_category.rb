class ServiceCategory < ApplicationRecord
  belongs_to :business
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 100 }
end
