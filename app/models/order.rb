class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum address: { ご自身の住所:0, 登録済住所から選択:1, 新しいお届け先:2 }
  
  def add_tax_sales_price
    (self.sales_price * 1.10).round
  end
end
