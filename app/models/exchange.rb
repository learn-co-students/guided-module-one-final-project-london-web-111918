class Exchange < ActiveRecord::Base
  has_many :token_exchanges
  has_many :tokens, through: :token_exchanges
end
