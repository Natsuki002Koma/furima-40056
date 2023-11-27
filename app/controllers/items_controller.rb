class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit
  before_action :set_item, only: [:edit, :update, :destroy]


  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.includes(:user).find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    order = Order.find_by(item_id: @item.id)
    if current_user == @item.user || order.present?
      redirect_to action: :index 
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
