class CreateExchanges < ActiveRecord::Migration[4.2]
  def change
    create_table :exchanges do |t|
      t.string :name
    end
  end
end
