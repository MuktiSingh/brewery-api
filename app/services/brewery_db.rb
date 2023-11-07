class BreweryDb
  BASE_URL = "https://api.openbrewerydb.org/v1/breweries"

  def initialize(method = nil, search_query = nil)
    @method = method
    @search_query = search_query
  end

  def list
    response = RestClient.get BASE_URL
    JSON.parse response
  end

  def search
    response = RestClient.get "#{BASE_URL}?#{@method}=#{sanitize_search}"
    JSON.parse response
  end

  def single(id)
    response = RestClient.get "#{BASE_URL}/#{id}"
    JSON.parse response
  end

  private

  def sanitize_search
    @search_query.squish.downcase.gsub(' ', '_')
  end
end
