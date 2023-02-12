class ItemsController < ApplicationController
  before_action :move_to_index, only: [:new]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :charge_id, :prefecture_id, :duration_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?

    redirect_to '/users/sign_in'
  end
end
