def run
  welcome
  intro
  menu_setting
end

def welcome
  hello = Artii::Base.new
  puts Rainbow(hello.asciify("Welcome    to    BitTrader")).yellow
end

def intro
  puts ""
  puts Rainbow("BitTrader is an app that lets cryptocurrency enthusiasts and traders evaluate").yellow
  puts Rainbow("the market to help them with their buying and selling decisions").yellow
  puts ""
  puts Rainbow("---------------------------").yellow
  puts Rainbow("Select a number from 1 - 7").yellow
  puts Rainbow("---------------------------").yellow
  puts ""
  puts (" 1. ") + "See current rate for your chosen token ** BTC, XMR, ETH, BCH, XLM **"
  puts (" 2. ") + "See full library of exchanges together with their tokens and currencies"
  puts (" 3. ") + "See exchanges that trade in your chosen currency"
  puts (" 4. ") + "See all exchanges that trade your chosen token"
  puts (" 5. ") + "See top exchanges sorted by 1-day token sale volume"
  puts (" 6. ") + "Refresh all data"
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
       puts Rainbow(goodbye.asciify("Thank  you  for  using  BitTrader")).yellow
       break
       else
       puts "That option does not exist. Please select a number from 1 - 7 "
   end
 end
end
