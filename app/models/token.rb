class Token < ActiveRecord::Base
  # belongs_to :ticker
  has_many :token_exchanges
  has_many :exchanges, through: :token_exchanges
end
