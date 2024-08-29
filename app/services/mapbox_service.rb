class MapboxService
  include HTTParty
  base_uri 'https://api.mapbox.com/geocoding/v5/mapbox.places'

  def initialize(api_key = ENV['MAPBOX_ACCESS_TOKEN'])
    @api_key = api_key
  end

  def search_category(longitude, latitude, category)
    options = { query: { proximity: "#{longitude},#{latitude}", access_token: @api_key, limit: 5 } }
    self.class.get("/#{category}.json", options)
  end
end