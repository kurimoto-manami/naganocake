class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
    @cart_item = CartItem.find_by(customer_id: current_customer.id)
    if !@cart_item.present?
      redirect_to cart_items_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order = @item.order.new(order_params)
    @order.save
    redirect_to items_path
  end

  def index
    @orders = Order.all
  end

  def show
    @item = Item.find(params[:item_id])
    @order = @item.order.new
    session[:cart] ||= {}
    session[:cart]["#{params[:id]}"] = Product.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def completion
   
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end


end
