class Jikan < ApplicationRecord
  belongs_to :user
  has_one :wage
  has_many :comments
end
