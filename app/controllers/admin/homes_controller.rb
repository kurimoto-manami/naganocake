class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all
    @orders = order.find(params[:id])
    @customer = current_customer
  end

end
