<a href="https://github.com/atkinsonholly/guided-module-one-final-project-london-web-111918"><img src="https://bitcoinist.com/wp-content/uploads/2018/06/shutterstock_1018654609.jpg" title="ModuleOneProject" alt="ModuleOneProject"></a>

# Flatiron School - Module One Project - Holly Atkinson and Andy Purbrick

### BitTrader CLI application ###

> Using the CoinAPI (Cryptocurrency Data API) for our Flatiron School Module One Project

> Tagline: "Bit Trader is an app that lets cryptocurrency enthusiasts and traders evaluate the market to help them with their buying and selling decisions"

## Getting started

Repository - (https://github.com/atkinsonholly/guided-module-one-final-project-london-web-111918)

Run BitTrader from your command line by entering:

```
ruby bin/run.rb

```
The BitTrader main menu should pop up in your terminal!

Select an option (1-7) from the main menu to proceed:

1. See current rate for your chosen token ** BTC, XMR, ETH, BCH, XLM **
2. See full library of exchanges together with their tokens and currencies
3. See exchanges that trade in your chosen currency
4. See all exchanges that trade your chosen token
5. See top exchanges sorted by 1-day token sale volume
6. Refresh all data
7. Exit

## Project background

Module One Project outline:
1. Build at least three models with corresponding tables, including a join table
2. Access a Sqlite3 Database using ActiveRecord
3. Seed database with data from an API
4. Build out a CLI that allows users to interact with database
5. Separate models for runner and CLI interface.

## MVP and Stretch Goals

MVP:
- Include a basic menu with which the user can interact
- Show the latest rate for a given token - for 3 tokens (BTC, ETH and XRP), in at least 2 currencies (USD, GBP)
- Show a list of all exchanges
- Show a list of exchanges for a selected token
- Include menu exit option

Stretch goals:
- Return the latest rate for a given token - for 5 tokens in total (BTC, ETH, XRP, BCH and XLM), in a wide range of currencies
- Include loops to ensure the user enters the correct information
- Enable uppercase, lowercase and mixed-case user input
- Include colour in the command line interface using ASCII art gems
- Include "BitTrader" logo using ASCII art gems
- Expand library to show the tokens and currencies that each exchange has
- Include option to show top exchanges by volume for a selected token
- Include option for user to refresh all data
- Organise the library of exchanges in alphabetical order

Gems used:
gem "sinatra-activerecord"
gem "sqlite3"
gem "pry"
gem "require_all"
gem 'rest-client'
gem 'artii'
gem 'rainbow'

## Authors

* **Holly Atkinson** - *Developer* - (https://github.com/atkinsonholly)
* **Andy Purbrick** - *Developer* - (https://github.com/apcrypto)

## License

The project was created under the CoinAPI Terms of Service - (https://www.coinapi.io/legal#terms)
