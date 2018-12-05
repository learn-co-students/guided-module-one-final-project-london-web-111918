class Addcurrencytotoken < ActiveRecord::Migration[5.2]
  def change
    add_column :tokens, :currency, :string
  end
end
