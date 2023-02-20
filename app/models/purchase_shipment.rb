class PurchaseShipment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase_id, :postal_code, :prefecture_id, :municipality, :address, :building, :tel, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Postal code is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :tel
    validates :municipality
    validates :address
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
  validates :token, presence: true
  validates :tel, numericality: { only_integer: true}
  validates :tel, length: { in: 10..11 }

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id, token: token)
    Shipment.create(postal_code: postal_code, prefecture_id: prefecture, municipality: municipality, address: address, building: building, tel: tel, purchase_id: purchase.id)
  end

end
