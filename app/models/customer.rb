class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :genres, dependent: :destroy
  has_one_attached :image
  

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
