class User < ApplicationRecord
  has_many :jikans
  has_many :wages

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
