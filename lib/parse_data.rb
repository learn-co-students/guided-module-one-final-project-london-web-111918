require 'uri'
require 'net/http'
require 'json'
require 'rest-client'
require_relative 'api_communicator'
require 'pry'

##### Save tokens

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
  response_hash_4 = get_data_from_api_rates("BCH")
  tokens_XRP = response_hash_3["rates"].each { |element| Token.create({name: "Bitcoin cash", slug: "BCH", rate: element["rate"], currency: element["asset_id_quote"]}) }
  # Get Stellar data and create Stellar tokens
  response_hash_5 = get_data_from_api_rates("XLM")
  tokens_XRP = response_hash_3["rates"].each { |element| Token.create({name: "Ripple", slug: "XLM", rate: element["rate"], currency: element["asset_id_quote"]}) }

end

##### Save exchanges

def list_of_exchanges
  Exchange.destroy_all
  response_hash_exchanges = get_data_from_api_symbols
  array = []
  response_hash_exchanges.each { |element| array << element["exchange_id"]}
  exchanges_all = array.uniq.each { |element| Exchange.create({name: element}) }
  array.uniq.sort
end

##### Save token_exchanges

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

##### Methods to return information to user

def current_rate_for_token

    token_list = ["BTC", "ETH", "BCH", "XRP", "XLM"]
    puts "Please choose from one of the following tokens: Bitcoin (BTC), Ethereum (ETH), Bitcoin Cash (BCH), Ripple (XRP), Stellar (XLM)"
    user_input_token = "BTC"
    if user_input_token.class != String || user_input_token.length > 3
      raise ArgumentError.new('Input must be a 3 character string')
      return true
    elsif user_input_token == "Exit" || user_input_token == "exit" || user_input_token == "EXIT"
      return true
    elsif token_list.include?(user_input_token) == false
      raise ArgumentError.new('Input must be one of: BTC, ETH, BCH, XRP, XLM')
    else
      array = ["ETH", "USDC", "XLM", "USDT", "GBP", "EUR", "USD", "BRL", "XRP","LTC", "TUSD", "DAI", "RUB", "JPY", "NZD", "GUSD", "DOGE", "PAX", "TRY", "EURS", "KRW", "CAD", "HUSD", "MXN", "PLN", "KST", "SLL", "AUD", "PHP", "ZAR", "NGN", "IDR", "NMC", "MYR", "UAH", "SGD", "NIS", "CNYX", "USNBT", "CZK", "THB", "DKKT", "NZDT", "CNNBT", "SEK", "RON", "NOK", "INR", "ILS", "HUF", "HRK", "HKD", "DKK", "CNY", "CHF", "BGN", "UST", "EURN", "VEN", "BTC", "WAVES", "ZEC", "BCH", "UNO", "HT", "EOS", "OKB", "BNB", "QASH", "RUR", "DASH", "NEO", "KCS", "ZBC", "CNET"]

      puts "Please enter a currency"
      user_input_currency = "USD"
      if user_input_currency.class != String || user_input_currency.length > 3
        raise ArgumentError.new('Input must be a 3 character string')
        return true
      elsif user_input_currency == "Exit" || user_input_currency== "exit" || user_input_currency == "EXIT"
        return true
      elsif array.include?(user_input_currency) == false
        raise ArgumentError.new('Input must be an authorised currency')
      else
        token = Token.all.find_by(slug: user_input_token, currency: user_input_currency)
        rate = token.rate
        name = token.name
        puts "The latest rate for #{name} in #{user_input_currency} is #{rate}."
        return true
      end
    end
end
current_rate_for_token
