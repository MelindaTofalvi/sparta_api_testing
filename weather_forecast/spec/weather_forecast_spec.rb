require 'spec_helper'
require 'resolv-replace' #avoid Net::OpenTimeout: execution expired

describe WeatherForecast do

	context 'requesting information by giving city id' do 
	
		before(:all) do
			@query = WeatherForecast.new
			@city = @query.get_weather_by_cityid(707860)
			# p @city

			puts JSON.pretty_generate(@city["city"]).gsub(":", " =>") #print pretty hash to the terminal

			puts JSON.pretty_generate(@city).gsub(":", " =>")

			# @russia = @query.get_weather_by_cityid(519188)
			# p @russia
		end

		# testing in #city["city"]

		it 'should respond with a status message of 200' do
			expect(@city["cod"]).to eq "200"
		end

		it 'should have a results hash' do
			expect(@city).to be_a Hash
		end

		it 'should return a city id between 5 and 8 in length' do
			expect(@city["city"]["id"].to_s.length).to be_between(5, 8)
		end

		it 'should return an integer value for a city id' do
			expect(@city["city"]["id"]).to be_a Integer
		end

		it 'should return a string for a city name that contains at least 3 characters' do
			expect(@city["city"]["name"]).to be_a String
		end

		it 'should return a string for a country code' do
			expect(@city["city"]["country"]).to be_a String
		end

		it 'should return a country code that has 2 characters' do
			expect(@city["city"]["country"].length).to eq 2
		end

		it 'should return a float or integer value for longitude' do
			expect(@city["city"]["coord"]["lon"]).to be_a Float or Integer
		end

		it 'should return a float or integer value for latitude' do
			expect(@city["city"]["coord"]["lat"]).to be_a Float or Integer
		end

		# testing other parts of the main hash

		it 'should return an array for list' do 
			expect(@city["list"]).to be_a Array
		end

		it 'should return an array for weather' do
			expect(@city["list"][0]["weather"]).to be_a Array
		end

		it 'should return that temp_max is higher than temp_min in list/main' do
			expect(@city["list"][0]["main"]["temp_max"]).to be > @city["list"][0]["main"]["temp_min"]
		end

		it 'should return a string for list/weather/description that has min 3 characterrs' do 
			expect(@city["list"][0]["weather"][0]["description"]).to be_a String
			expect(@city["list"][0]["weather"][0]["description"].length).to be >= 3
		end

		it 'should return a hash for list/wind' do
			expect(@city["list"][0]["wind"]).to be_a Hash
		end

		it 'should return an Integer for dt' do
			expect(@city["list"][0]["dt"]).to be_a Integer
		end

		it 'should return a hash for list/main' do
			expect(@city["list"][0]["main"]).to be_a Hash
		end

		it 'should return an Integer for list/clouds/all that cannot be negative' do
			expect(@city["list"][1]["clouds"]["all"]).to be_a Integer
			expect(@city["list"][1]["clouds"]["all"]).to be >= 0
		end

		it 'should return a float for message' do
			expect(@city["message"]).to be_a Float
		end

		it 'should return an integer for cnt that is bigger than 0' do
			expect(@city["cnt"]).to be_a Integer
			expect(@city["cnt"]).to be > 0
		end


	end
end