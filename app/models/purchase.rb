class Purchase < ApplicationRecord
  attr_accessor :token

  belongs_to :user
  belongs_to :item
  has_one :shipment, dependent: :delete
  has_one_attached :image
end
