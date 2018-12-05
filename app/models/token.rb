class Token < ActiveRecord::Base
  # belongs_to :ticker
  has_many :token_exchanges
  has_many :exchanges, through: :token_exchanges

  array = ["ETH", "USDC", "XLM", "USDT", "GBP", "EUR", "USD", "BRL", "XRP","LTC", "TUSD", "DAI", "RUB", "JPY", "NZD", "GUSD", "DOGE", "PAX", "TRY", "EURS", "KRW", "CAD", "HUSD", "MXN", "PLN", "KST", "SLL", "AUD", "PHP", "ZAR", "NGN", "IDR", "NMC", "MYR", "UAH", "SGD", "NIS", "CNYX", "USNBT", "CZK", "THB", "DKKT", "NZDT", "CNNBT", "SEK", "RON", "NOK", "INR", "ILS", "HUF", "HRK", "HKD", "DKK", "CNY", "CHF", "BGN", "UST", "EURN", "VEN", "BTC", "WAVES", "ZEC", "BCH", "UNO", "HT", "EOS", "OKB", "BNB", "QASH", "RUR", "DASH", "NEO", "KCS", "ZBC", "CNET"]
  
  validates :currency, inclusion: { in: array }

end
