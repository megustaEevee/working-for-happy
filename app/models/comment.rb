class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :jikan

  validates :text, presence: true
end
