class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}
  # def add_tax_sales_price
  #   (self.sales_price * 1.10).round
  # end

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  # def total_price
  #   cart_item.subtotal
  # end
end
