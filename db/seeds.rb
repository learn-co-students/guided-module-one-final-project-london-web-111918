t1 = Token.create({name: "Bitcoin", slug: "BTC", rate: 2000})
exchange1 = Exchange.create({name: "Bitfinex"})
token_exchange1 = TokenExchange.create({token_id: 1, exchange_id: 1, volume: 34000.00})
