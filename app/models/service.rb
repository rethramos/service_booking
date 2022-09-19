class Service < ApplicationRecord
  belongs_to :business
  belongs_to :service_category
end
