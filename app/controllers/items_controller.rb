class ItemsController < ApplicationController
  before_action :move_to_index_or_sign_in, only: [:edit]
  before_action :move_to_index, only: [:new]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
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

  def move_to_sign_in
    return if user_signed_in?

    redirect_to '/users/sign_in'
  end

  def move_to_index_or_sign_in
    if user_signed_in?
      redirect_to action: :index unless current_user.id == Item.find(params[:id]).user_id
    else
      redirect_to '/users/sign_in'
    end
  end
end
