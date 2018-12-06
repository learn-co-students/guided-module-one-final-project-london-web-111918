def run
  welcome
  intro
  menu_setting
end

def welcome
  hello = Artii::Base.new
  puts hello.asciify("Welcome    to    BitTrader")
end

def intro
  puts ""
  puts "Bit Trader is an app that lets cryptocurrency enthusiasts and traders evaluate"
  puts "the market to help them with their buying and selling decisions"
  puts ""
  puts "---------------------------"
  puts "Select a number from 1 - 7"
  puts "---------------------------"
  puts ""
  puts (" 1. ") + "Choose token: BTC, XMR, ETH, BCH, XLM ** returns current rate **"
  puts (" 2. ") + "See library of exchanges with their tokens and currencies"
  puts (" 3. ") + "See exchanges trading selected currency"
  puts (" 4. ") + "See list of exchanges trading selected token"
  puts (" 5. ") + "Exchanges sorted by 1-day token sale volume"
  puts (" 6. ") + "Refresh all data (not recommended)"
  puts (" 7. ") + "Exit"
  puts ""
  puts ""
end

def menu_setting
 input = " "
 while input
   input = gets.chomp
   case input
     when "1"
       current_rate_for_token
     when "2"
       show_all_exchanges_with_tokens_and_currencies
     when "3"
       show_exchanges_for_currency
     when "4"
       show_exchanges_for_token
     when "5"
       sort_exchanges_by_volume_for_token
     when "6"
       refresh_all_data
     when "7"
       goodbye = Artii::Base.new
       puts goodbye.asciify("Thank   you   for   using   BitTrader")
       break
       else
       puts "That option does not exist. Please select a number from 1 - 7 "
   end
 end
end
