class Createtokenexchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :token_exchanges do |t|
      t.integer :token_id
      t.integer :exchange_id
    end
  end
end
