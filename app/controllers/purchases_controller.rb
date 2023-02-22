class PurchasesController < ApplicationController

  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_shipment = PurchaseShipment.new
  end

  def create
    @purchase_shipment = PurchaseShipment.new(purchase_params)
    if @purchase_shipment.valid?
      pay_item
      @purchase_shipment.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_shipment).permit(:postal_code, :prefecture_id, :municipality, :address, :building, :tel, :purchase_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, 
      card: purchase_params[:token], 
      currency: 'jpy' 
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    @purchases_itemid = Purchase.pluck('item_id')
    if current_user.id == @item.user_id || @purchases_itemid.include?(@item.id)
      redirect_to root_path
    end
  end

end
