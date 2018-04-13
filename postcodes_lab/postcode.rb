require 'httparty'
require 'json'

class Postcodesio
  include HTTParty

  base_uri 'https://api.postcodes.io'

  def single_postcode_response(postcode)
    JSON.parse(self.class.get("/postcodes/#{postcode}").body)

  end

  def multiple_postcodes_response(postcodes_array)
    JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_array}).body)
  end

end



