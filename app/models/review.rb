# Model class Review
class Review < ApplicationRecord
  ### ASSOCIATIONS ###

  belongs_to :user

  ### VALIDATIONS ###

  validates :rating, numericality: { greater_than: -1, less_than: 6 }
  validates :brewery_id, presence: true
end
