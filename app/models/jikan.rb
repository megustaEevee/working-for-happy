class Jikan < ApplicationRecord
  belongs_to :user
  has_one :wage
end
