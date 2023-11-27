class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render  :index, status: :unprocessable_entity
    end
  end

  private
  def order_params
    @item = Item.find(params[:item_id])
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :street, :building, :tel).merge(item_id: @item.id, user_id: current_user.id)
  end
end
