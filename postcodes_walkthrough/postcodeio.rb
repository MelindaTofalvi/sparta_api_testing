require 'httparty'
require 'json'

class Postcodesio
	include HTTParty # we include httparty module in the class

	attr_accessor :single_postcode_result, :multiple_postcodes_result

	base_uri 'https://api.postcodes.io/'

	def single_postcode_search(postcode)
		@single_postcode_result = self.class.get("/postcodes/#{postcode}")
		puts JSON.parse(@single_postcode_result.body)
		#self.class => this how we get access to the module's method
	end

	#post request
	def multiple_postcodes_search(postcode_array)
		@multiple_postcodes_result = self.class.post("/postcodes", :body => {'postcodes': postcode_array})
		puts JSON.parse(@multiple_postcodes_result.body)

	end

end

single = Postcodesio.new
#single.single_postcode_search('b601ja')
single.multiple_postcodes_search(['b601ja', 'sw155du'])