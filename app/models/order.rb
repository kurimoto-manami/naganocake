class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def add_tax_sales_price
    (self.sales_price * 1.10).round
  end
end
