require 'uri'
require 'net/http'
require 'json'
require 'rest-client'

def get_data_from_api_rates(ticker) #gets tokens, currencies and rates
  response_string = RestClient.get("https://rest.coinapi.io/v1/exchangerate/" + ticker + "?apikey=9EE71748-0D09-4105-9B03-ED532F53A3F3")
  response_hash = JSON.parse(response_string)
end

def get_data_from_api_symbols #gets volumes by token and exchange
  response_string = RestClient.get("https://rest.coinapi.io/v1/symbols?apikey=9EE71748-0D09-4105-9B03-ED532F53A3F3")
  response_hash = JSON.parse(response_string)
  #puts response_hash
end

def get_data_from_api_exchanges #exchange IDs, websites and date information
  response_string = RestClient.get("https://rest.coinapi.io/v1/exchanges?apikey=9EE71748-0D09-4105-9B03-ED532F53A3F3")
  response_hash = JSON.parse(response_string)
end
