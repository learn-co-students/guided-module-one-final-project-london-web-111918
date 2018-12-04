require 'uri'
require 'net/http'
require 'json'
require 'rest-client'

def get_data_from_api_rates(ticker)
  response_string = RestClient.get("https://rest.coinapi.io/v1/exchangerate/" + ticker + "?apikey=6A5C870F-0754-4F70-B631-3469A5642D07")
  #{"asset_id_base"=>"BTC", "rates"=>[{"time"=>"2018-12-04T12:46:38.9712857Z", "asset_id_quote"=>"BITON", "rate"=>61431904.55605661}...]
  response_hash = JSON.parse(response_string)
  puts response_hash
end

 #get_data_from_api_rates("BTC")

 def get_current_exchange_rate_between_ticker_and_currency(ticker, currency)
   response_hash = get_data_from_api_rates(ticker)
   rate_hash = response_hash["rates"].find {|hash| hash["rate"] if hash["asset_id_quote"] = currency}["rate"]
   #rate_hash = response_hash["rates"].select {|hash| hash["rate"] if hash["asset_id_quote"] = currency}
   #puts rate_hash[0]["rate"]
   puts rate_hash
 end

#get_current_exchange_rate_between_ticker_and_currency("BTC", "USD")

def get_data_from_api_symbols #volume information
  response_string = RestClient.get("https://rest.coinapi.io/v1/symbols?apikey=6A5C870F-0754-4F70-B631-3469A5642D07")
  response_hash = JSON.parse(response_string)
  puts response_hash
end

#get_data_from_api_symbols

# [{"symbol_id"=>"DERIBIT_OPT_BTC_USD_190125_6250_P", "exchange_id"=>"DERIBIT", "symbol_type"=>"OPTION", "asset_id_base"=>"BTC", "asset_id_quote"=>"USD", "option_type_is_call"=>false, "option_strike_price"=>6250.0, "option_contract_unit"=>1.0, "option_exercise_style"=>"EUROPEAN", "option_expiration_time"=>"2019-01-25T08:00:00.0000000Z", "data_start"=>"2018-12-03", "data_end"=>"2018-12-04", "data_quote_start"=>"2018-12-03T04:04:54.8358106Z", "data_quote_end"=>"2018-12-04T00:00:00.0000000Z", "data_orderbook_start"=>"2018-12-03T04:04:54.8358106Z", "data_orderbook_end"=>"2018-12-04T00:00:00.0000000Z", "volume_1hrs"=>0.0, "volume_1hrs_usd"=>0.0, "volume_1day"=>0.0, "volume_1day_usd"=>0.0, "volume_1mth"=>0.0, "volume_1mth_usd"=>0.0}...]

def get_data_from_api_exchanges #exchange IDs, websites and date information
  response_string = RestClient.get("https://rest.coinapi.io/v1/exchanges?apikey=6A5C870F-0754-4F70-B631-3469A5642D07")
  response_hash = JSON.parse(response_string)
  puts response_hash
end
# get_data_from_api_exchanges


  # [{
  #   "exchange_id": "OKCOIN_CNY",
  #   "website": "https://www.okcoin.cn/",
  #   "name": "OKCoin CNY",
  #   "data_start": "2013-06-12",
  #   "data_end": "2018-03-09",
  #   "data_quote_start": "2015-02-15T12:53:50.3430000Z",
  #   "data_quote_end": "2018-03-09T00:00:00.0000000Z",
  #   "data_orderbook_start": "2015-02-15T12:53:50.3430000Z",
  #   "data_orderbook_end": "2018-03-09T00:00:00.0000000Z",
  #   "data_trade_start": "2013-06-12T14:24:24.0000000Z",
  #   "data_trade_end": "2017-11-01T00:00:00.0000000Z",
  #   "data_trade_count": 2085401174,
  #   "data_symbols_count": 2
  # }...]

#latest
#https://rest.coinapi.io/v1/ohlcv/BITSTAMP_SPOT_BTC_USD/latest?period_id=1MIN
