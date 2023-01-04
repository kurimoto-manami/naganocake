class Admin::OrdersController < ApplicationController

  
  def show
    @order = order.find(params[:id])
  end
  
end
