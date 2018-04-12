require 'httparty'
require 'json'
require 'resolv-replace'

class WeatherForecast
	include HTTParty

	base_uri 'http://api.openweathermap.org/data/2.5'

	@api_key = '31ab1f6660b42c48cd864a222503c25a'

	# def get_weather_by_cityname(cityname, country_code)
	# 	p JSON.parse(self.class.get("https://openweathermap.org/data/2.5/forecast?q=#{cityname},#{country_code}").body)
	# end

	def get_weather_by_cityid(cityid)
		JSON.parse(self.class.get("/forecast?id=#{cityid}&APPID=31ab1f6660b42c48cd864a222503c25a").body)
	end
end