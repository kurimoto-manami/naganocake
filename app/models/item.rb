class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_detas
  belongs_to :genre
  has_one_attached :image

  def active_for_authentication?
    super && (is_active == false)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # def add_tax_sales_price
  #   (self.sales_price * 1.10).round
  # end

  def converting_to_jpy(price)
    "#{price.to_i(:delimited, delimiter: ',')}円"
  end
#   with_options presence: true do
#   validates :name
#   validates :introduction
#   validates :price
#   validates :is_active
#   validates :image
#   end

end
