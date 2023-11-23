class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = Address.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render  :index
    end
  end

  private
  def order_params
    params.require(:order).merge(user_id: current_user.id, item_id: @item.id)
  end
end
