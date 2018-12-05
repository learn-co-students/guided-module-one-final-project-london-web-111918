require 'uri'
require 'net/http'
require 'json'
require 'rest-client'
require_relative 'api_communicator'
require 'pry'

##### Save tokens t1 = Token.create({name: "Bitcoin", slug: "BTC", rate: 2000})

def save_tokens_to_db
  Token.destroy_all

  # Get Bitcoin data and create Bitcoin tokens
  response_hash = get_data_from_api_rates("BTC")
  tokens_BTC = response_hash["rates"].each { |element| Token.create({name: "Bitcoin", slug: "BTC", rate: element["rate"], currency: element["asset_id_quote"]}) }
  # Get Ethereum data and create Ethereum tokens
  response_hash_2 = get_data_from_api_rates("ETH")
  tokens_ETH = response_hash_2["rates"].each { |element| Token.create({name: "Ethereum", slug: "ETH", rate: element["rate"], currency: element["asset_id_quote"]}) }
  # Get Ripple data and create Ripple tokens
  response_hash_3 = get_data_from_api_rates("XRP")
  tokens_XRP = response_hash_3["rates"].each { |element| Token.create({name: "Ripple", slug: "XRP", rate: element["rate"], currency: element["asset_id_quote"]}) }
  # Get Bitcoin cash data and create Bitcoin cash tokens
  response_hash_4 = get_data_from_api_rates("XRP")
  tokens_XRP = response_hash_3["rates"].each { |element| Token.create({name: "Bitcoin cash", slug: "BCH", rate: element["rate"], currency: element["asset_id_quote"]}) }
  # Get Stellar data and create Stellar tokens
  response_hash_5 = get_data_from_api_rates("XLM")
  tokens_XRP = response_hash_3["rates"].each { |element| Token.create({name: "Ripple", slug: "XLM", rate: element["rate"], currency: element["asset_id_quote"]}) }

end

##### Save exchanges exchange1 = Exchange.create({name: "Bitfinex"})

def list_of_exchanges
  Exchange.destroy_all
  response_hash_exchanges = get_data_from_api_symbols
  array = []
  response_hash_exchanges.each { |element| array << element["exchange_id"]}
  exchanges_all = array.uniq.each { |element| Exchange.create({name: element}) }
  array.uniq.sort
end

##### Save token_exchanges token_exchange1 = TokenExchange.create({token_id: 1, exchange_id: 1, volume: 34000.00})

def save_token_exchanges_to_db
  TokenExchange.destroy_all
  response_hash_token_exchanges = get_data_from_api_symbols
  response_hash_token_exchanges = response_hash_token_exchanges.select {|element| element["symbol_type"] == "SPOT"}

  response_hash_token_exchanges.each do |element|
    token = Token.find_by(slug: element["asset_id_base"], currency: element["asset_id_quote"])
    exchange = Exchange.find_by(name: element["exchange_id"])
    if token != nil && exchange != nil
      TokenExchange.create( {token_id: token.id, exchange_id: exchange.id, volume: element["volume_1day"] } )
    end
  end
end

#<Token:0x007f9bc7310dc0
 # id: 10319,
 # name: "Bitcoin",
 # slug: "BTC",
 # rate: 14692.795771058958,
 # currency: "PLN">

 #<Exchange:0x007f9bc6cfad50 id: 119220, name: "BITMEX">


#
# {"symbol_id"=>"BITMEX_PERP_ETH_USD",
#   "exchange_id"=>"BITMEX",
#   "symbol_type"=>"PERPETUAL",
#   "asset_id_base"=>"ETH",
#   "asset_id_quote"=>"USD",
#   "asset_id_unit"=>"ETH",
#   "data_start"=>"2018-08-02",
#   "data_end"=>"2018-12-05",
#   "data_quote_start"=>"2018-08-02T09:04:09.0157660Z",
#   "data_quote_end"=>"2018-12-05T00:00:00.0000000Z",
#   "data_orderbook_start"=>"2018-08-02T09:04:09.0157660Z",
#   "data_orderbook_end"=>"2018-12-05T00:00:00.0000000Z",
#   "data_trade_start"=>"2018-08-02T09:06:10.6871980Z",
#   "data_trade_end"=>"2018-12-05T00:00:00.0000000Z",
#   "volume_1hrs"=>6537704.0,
#   "volume_1hrs_usd"=>706318669.24,
#   "volume_1day"=>274194687.0,
#   "volume_1day_usd"=>29623370289.51,
#   "volume_1mth"=>30018782573.0,
#   "volume_1mth_usd"=>3243160987288.45},
