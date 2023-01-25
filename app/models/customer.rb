class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_one_attached :image
  has_many :addresses
  has_many :cart_items, dependent: :destroy
  has_many :orders

  # validates :name
  # validates :status

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
