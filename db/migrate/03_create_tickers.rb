class CreateTickers < ActiveRecord::Migration[4.2]
  def change
    create_table :tickers do |t|
      t.string :name
      t.string :ticker
    end
  end
end
