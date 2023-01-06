class Admin::OrdersController < ApplicationController

  
  def show
    @order = order.find(params[:id])
    @customers = @order.customers.page(params[:page])
  end
  
end
