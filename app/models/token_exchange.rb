class TokenExchange < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :token
  #belongs_to :volume, through: :token_exchanges
end
