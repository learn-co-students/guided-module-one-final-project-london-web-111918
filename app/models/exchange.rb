class Exchange < ActiveRecord::Base
  has_many :tickers
  has_many :spot_prices, through: :tickers
end
