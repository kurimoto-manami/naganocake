class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
    @customer = current_customer
    @order_details = OrderDetail.all
  end

end
