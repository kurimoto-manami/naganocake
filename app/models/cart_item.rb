class CartItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :customer
  
  def sum_of_price
    product.price * quantity
  end
end
