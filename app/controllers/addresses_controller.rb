class AddressesController < ApplicationController
  def create
    @order = order.find(params[:order_id])
    @address = Order.address.new(address_params) 
    @address.save
    if @address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def address_params
    params.require(:oder).permit(:post_code, :prefecture_id, :city, :street, :building, :tel).merge(order_id: @order.id)
  end
end
