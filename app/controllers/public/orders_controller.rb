class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
  end
  
  def create
    @item = Item.find(params[:item_id])
    @order = @item.order.new(order_params)
    @order.save
    redirect_to items_path
  end
  
  def index
    @orders = Order.all
    @orders = Order.find(params[:id])
  end
  
  def show
    @item = Item.find(params[:item_id])
    @order = @item.order.new
    session[:cart] ||= {}
    session[:cart]["#{params[:id]}"] = Product.find(params[:id])
  end
  
  def confirm
    @item = Item.find(params[:item_id])
    @order = @item.order.new(order_params)
  end
  
  def completion
  end
  
  
  private

  def order_params
    params.require(:order).permit(:sipping_cost, :total_payment, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end
  
end
