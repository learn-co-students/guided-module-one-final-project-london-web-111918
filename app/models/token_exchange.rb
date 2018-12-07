class TokenExchange < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :token
end
