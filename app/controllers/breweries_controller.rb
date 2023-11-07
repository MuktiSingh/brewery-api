class BreweriesController < ApplicationController
  def index
    if params[:search_type].present?
      @breweries = BreweryDb.new(params[:search_type], params[:search]).search
    else
      @breweries = BreweryDb.new.list
    end
  end

  def show
    @brewery = BreweryDb.new.single(params[:id])
    @reviews = Review.where(brewery_id: params[:id])
  end

  def add_review
    @review = Review.new(review_params)

    if @review.save
      redirect_to brewery_path(@review.brewery_id), notice: 'Review added successfully'
    else
      render brewery_path
    end
  end

  private def review_params
    params.require(:review).permit(:user_id, :rating, :description, :brewery_id)
  end
end
