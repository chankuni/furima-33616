class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]


  def index
    @items = Item.all.order('created_at DESC')
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
  end

  def edit
  end

  def destroy
      @item.destroy
      redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :charge_id, :prefecture_id, :duration_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end


  # def move_to_index
  #   unless current_user.id == @item.user_id
  #     redirect_to root_path
  #   end
  # end

  # def move_to_index2
  #   @purchases_itemid = Purchase.pluck('item_id')
  #   if @purchases_itemid.include?(@item.id)
  #     redirect_to root_path
  #   end
  # end

  def move_to_index
    if current_user.id != @item.user_id || @item.purchase.present?
      redirect_to root_path
    end
  end

end
