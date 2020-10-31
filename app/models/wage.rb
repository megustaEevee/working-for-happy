class Wage < ApplicationRecord
  belongs_to :user
  belongs_to :jikan

  validates :end_time, presence: true
  validates :paying, presence: true

end
