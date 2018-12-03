class CreateSpotPrices < ActiveRecord::Migration[4.2]
  def change
    create_table :spot_prices do |t|
      t.string :ticker
      t.float :spot_price
      t.string :exchange_id
    end
  end
end
