class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_detas
  belongs_to :genres
  has_one_attached :image
  enum is_active: { on_sale: 0, suspended: 1 }


#   with_options presence: true do
#   validates :name
#   validates :introduction
#   validates :price
#   validates :is_active
#   validates :image
#   end

end
