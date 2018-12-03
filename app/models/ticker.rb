class Ticker < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :spot_price
end
