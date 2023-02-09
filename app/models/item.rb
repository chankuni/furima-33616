class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :charge
  belongs_to :duration
  belongs_to :prefecture
  belongs_to :status
  has_one_attached :image
  belongs_to :user


  validates :name, :description, :category_id, :status_id, :charge_id, :prefecture_id, :duration_id, :price, :image, presence: true
  validates :category_id, :status_id, :charge_id, :prefecture_id, :duration_id, numericality: { other_than: 1 , message: "can't be blank"}
  
  validates :price, numericality: {only_integer: true, message: 'Half-width number'}
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
   
end