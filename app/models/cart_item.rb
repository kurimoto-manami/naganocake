class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  def sum_price
    item.taxin_price * quantity
  end
end
