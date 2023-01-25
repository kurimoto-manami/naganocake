class Admin::OrdersController < ApplicationController

  def show
    # @order_url
    # @order = current_customer.order.new(order_params)
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.sipping_cost = 800
    @total = 0
    @order_details.each do |order_detail|
    @total = @total + order_detail.subtotal
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.save
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :sipping_cost, :total_payment, :payment_method, :status)
  end

end