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


##### Methods to return information to user through command_line_interface


##### METHOD ONE
def current_rate_for_token

  token_list = ["BTC", "ETH", "BCH", "XRP", "XLM"]
  puts "Please choose from one of the following tokens: Bitcoin (BTC), Ethereum (ETH), Bitcoin Cash (BCH), Ripple (XRP), Stellar (XLM)"
  user_input_token = gets.chomp.upcase
  while token_list.include?(user_input_token) == false
    puts "Please select from: BTC, ETH, BCH, XRP, XLM"
    user_input_token = gets.chomp.upcase
  end
  array = ["ETH", "USDC", "XLM", "USDT", "GBP", "EUR", "USD", "BRL", "XRP","LTC", "TUSD", "DAI", "RUB", "JPY", "NZD", "GUSD", "DOGE", "PAX", "TRY", "EURS", "KRW", "CAD", "HUSD", "MXN", "PLN", "KST", "SLL", "AUD", "PHP", "ZAR", "NGN", "IDR", "NMC", "MYR", "UAH", "SGD", "NIS", "CNYX", "USNBT", "CZK", "THB", "DKKT", "NZDT", "CNNBT", "SEK", "RON", "NOK", "INR", "ILS", "HUF", "HRK", "HKD", "DKK", "CNY", "CHF", "BGN", "UST", "EURN", "VEN", "BTC", "WAVES", "ZEC", "BCH", "UNO", "HT", "EOS", "OKB", "BNB", "QASH", "RUR", "DASH", "NEO", "KCS", "ZBC", "CNET"]
  puts "Please enter a currency"
  user_input_currency = gets.chomp.upcase
  while array.include?(user_input_currency) == false
    puts "Please enter a valid 3 character currency code"
    user_input_currency = gets.chomp.upcase
  end
  token = Token.all.find_by(slug: user_input_token, currency: user_input_currency)
  rate = token.rate
  name = token.name
  puts "The latest rate for #{name} in #{user_input_currency} is #{rate}."
  return true
end


##### METHOD TWO
def show_all_exchanges_with_tokens_and_currencies

  hash = {}
  Exchange.all.each do | exchange |
    my_hash = {}
    hash[exchange.name] = my_hash
    exchange.tokens.each do | token |
      my_hash[token.name] = token.currency
    end
  end
  puts hash
  return true
end


##### METHOD THREE
def show_exchanges_for_currency
  array = ["ETH", "USDC", "XLM", "USDT", "GBP", "EUR", "USD", "BRL", "XRP","LTC", "TUSD", "DAI", "RUB", "JPY", "NZD", "GUSD", "DOGE", "PAX", "TRY", "EURS", "KRW", "CAD", "HUSD", "MXN", "PLN", "KST", "SLL", "AUD", "PHP", "ZAR", "NGN", "IDR", "NMC", "MYR", "UAH", "SGD", "NIS", "CNYX", "USNBT", "CZK", "THB", "DKKT", "NZDT", "CNNBT", "SEK", "RON", "NOK", "INR", "ILS", "HUF", "HRK", "HKD", "DKK", "CNY", "CHF", "BGN", "UST", "EURN", "VEN", "BTC", "WAVES", "ZEC", "BCH", "UNO", "HT", "EOS", "OKB", "BNB", "QASH", "RUR", "DASH", "NEO", "KCS", "ZBC", "CNET"]
  puts "Please enter a currency"
  user_input_currency = gets.chomp.upcase
  while array.include?(user_input_currency) == false
    puts "Please enter a valid 3 character currency code"
    user_input_currency = gets.chomp.upcase
  end
  array = []
  Exchange.all.each do | exchange |
  exchange.tokens.each do | token |
    if token.currency == user_input_currency
      array << exchange.name
    end
  end
  end
  if array.length > 1
  puts "The exchanges that trade in #{user_input_currency} are: #{array.sort.join(', ')}."
  return true
  elsif array.length == 0
  puts "There are no exchanges that trade in #{user_input_currency}."
  return true
  elsif
  puts "The only exchange that trades in #{user_input_currency} is #{array[0]}."
  return true
  end
end


##### METHOD FOUR
def show_exchanges_for_token
  token_list = ["BTC", "ETH", "BCH", "XRP", "XLM"]
  puts "Please choose from one of the following tokens: Bitcoin (BTC), Ethereum (ETH), Bitcoin Cash (BCH), Ripple (XRP), Stellar (XLM)"
  user_input_token = gets.chomp.upcase
  while token_list.include?(user_input_token) == false
    puts "Please select from: BTC, ETH, BCH, XRP, XLM"
    user_input_token = gets.chomp.upcase
  end
  array = []
  Token.all.each do |token|
    if token.slug == user_input_token
      token.exchanges.each do | exchange |
        array << exchange.name
      end
    end
  array = array.uniq.sort
  end
  if array.length > 1
    puts "The exchanges that trade #{user_input_token} are: #{array.sort.join(', ')}."
    return true
  elsif array.length == 0
    puts "There are no exchanges that trades #{user_input_token}."
    return true
  elsif
    puts "The only exchange that has #{user_input_token} is #{array[0]}."
    return true
  end
end


##### METHOD FIVE
def sort_exchanges_by_volume_for_token
  token_list = ["BTC", "ETH", "BCH", "XRP", "XLM"]
  puts "Please choose from one of the following tokens: Bitcoin (BTC), Ethereum (ETH), Bitcoin Cash (BCH), Ripple (XRP), Stellar (XLM)"
  user_input_token = gets.chomp.upcase
  while token_list.include?(user_input_token) == false
    puts "Please select from: BTC, ETH, BCH, XRP, XLM"
    user_input_token = gets.chomp.upcase
  end
  array_of_names = []
  array_of_volumes = []
  Token.all.each do | token |
    if token.slug == user_input_token
    token.token_exchanges.each do | token_exchange |
        array_of_names << token_exchange.exchange.name
        array_of_volumes << token_exchange.volume.round(1)
      end
    end
  end
  array = array_of_names.zip(array_of_volumes).sort_by{|name, vol| vol}
  if array.length >= 5
    puts "The top 5 exchanges in order of 1-day volume for #{user_input_token} are as follows: "
    puts array[-1]
    puts array[-2]
    puts array[-3]
    puts array[-4]
    puts array[-5]
    return true
  elsif array.length < 5 && array.length >= 1 #very unlikely to be used for selected 5 tokens!
    puts "The top exchanges in order of 1-day volume for #{user_input_token} are as follows: "
    puts array
    return true
  elsif array.length == 0 #very unlikely to be used for selected 5 tokens!
    puts "There are no exchanges."
    return true
  end
end


##### METHOD SIX
def refresh_all_data
  save_tokens_to_db
  list_of_exchanges
  save_token_exchanges_to_db
end
