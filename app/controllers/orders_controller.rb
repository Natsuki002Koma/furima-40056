class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

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

  def move_to_index
    @item = Item.find(params[:item_id])
    order = Order.find_by(item_id: @item.id)
    if (current_user == @item.user) || order.present?
      redirect_to root_path
    end
  end
end
