class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :items
  # has_one_attached :image
  has_many :customers, dependent: :destroy
  # enum role: { public: 0, admin: 1 }

end
