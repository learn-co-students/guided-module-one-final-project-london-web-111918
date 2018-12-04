def welcome
  puts "Hello!"
end

def get_ticker_from_user
  puts "Please enter a 3 character ticker"
  gets.chomp.downcase
end
