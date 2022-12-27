class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_detas
  has_one_attached :image
  
#   with_options presence: true do
#   validates :name
#   validates :introduction
#   validates :price
#   validates :is_active
#   validates :image
#   end
  
end
