class SpotPrice < ActiveRecord::Base
  belongs_to :ticker
  has_many :exchanges, through: :tickers
end
