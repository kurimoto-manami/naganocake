class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_detas
  
#   with_options presence: true do
#   validates :name
#   validates :introduction
#   validates :price
#   validates :is_active
#   validates :image
#   end
  
  has_one_attached :image
end
