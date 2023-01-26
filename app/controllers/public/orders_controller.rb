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
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if  @order.save
      @cart_items.each do |cart_item|
        cart_item.item.price * cart_item.amount
        @order_details = OrderDetail.new
        @order_details.item_id = cart_item.item_id
        @order_details.order_id = @order.id
        @order_details.amount = cart_item.amount
        @order_details.price = @order.total_payment
        @order_details.making_status = 0
        @order_details.save!
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
    @orders = current_customer.orders
  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
    @orders = Order.all
    @order.sipping_cost = 800
    @total = 0
    @cart_items = current_customer.cart_items
    @order_details.each do |order_detail|
    @total = @total + order_detail.subtotal
    end
    @order.total_payment = @total + @order.sipping_cost
  end

  def confirm
    @address = Address.find(params[:order][:address_id])
    @order = current_customer.orders.new(order_params)
    @order.sipping_cost = 800
    @total = 0
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
    @total = @total + cart_item.subtotal
    end
    @order.total_payment = @total + @order.sipping_cost
    # @order = Order.new(customer_id: current_customer.id)
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
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :sipping_cost, :customer_id, :status, :total_payment)
  end

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end


end
