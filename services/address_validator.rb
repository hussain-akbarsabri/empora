require 'httparty'
require 'yaml'

class AddressValidator
  API_ENDPOINT = 'https://us-street.api.smartystreets.com/street-address'
  ENV = YAML.load_file('env.yml')

  def initialize(address)
    @response = HTTParty.get(API_ENDPOINT, query: {
      'auth-id': ENV['AUTH_ID'],
      'auth-token': ENV['AUTH_TOKEN'],
      'street': address[:street],
      'city': address[:city],
      'zipcode': address[:zip_code]
    })
  end

  def validate()
    if !@response.empty? && @response.code == 200
      "#{@response[0]['delivery_line_1']}, #{@response[0]['components']['city_name']}, #{@response[0]['last_line'].split().last}"
    else
      'Invalid Address'
    end
  end
end
