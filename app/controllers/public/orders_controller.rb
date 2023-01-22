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
    # @item = Item.find(params[:item_id])
    # @order = @item.order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
      if  @order.save
      @cart_items.each do |cart_item|
        cart_item.item.price * cart_item.amount
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.amount = cart_item.amount
        @order_detail.price = cart_item.item.with_tax_price
        @order_detail.save
      end
      redirect_to completion_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
    # redirect_to items_path
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
    # @cart_item = CartItem.find(params[:id])
    # @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order = current_customer.orders.new(order_params)
    if params[:order][:address_serect] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_serect] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
    elsif params[:order][:address_serect] == "2"
      address_new = current_customer.addresses.new(address_params)
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
  end

  def completion

  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :sipping_cost)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
