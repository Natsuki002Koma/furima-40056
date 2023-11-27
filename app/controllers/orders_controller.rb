class OrdersController < ApplicationController
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render  :index, status: :unprocessable_entity
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end
  end

  private
  def order_params
    @item = Item.find(params[:item_id])
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :street, :building, :tel).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    @item = Item.find(params[:item_id])
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
