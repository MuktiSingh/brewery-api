# Brewery Helper
module BreweryHelper
  def brewery_average_rating(id)
    Review.where(brewery_id: id).average(:rating)&.round(2)
  end
end
