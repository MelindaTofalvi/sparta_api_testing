require 'httparty'

response = HTTParty.get('http://bbc.co.uk/news') # 'get' request to the url

puts response.code #200 or 404, 410, etc. // http.cat
puts response.message # the message comes with the code: 200 => OK
