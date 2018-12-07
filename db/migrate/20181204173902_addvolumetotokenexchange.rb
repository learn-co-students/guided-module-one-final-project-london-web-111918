class Addvolumetotokenexchange < ActiveRecord::Migration[5.2]
  def change
    add_column :token_exchanges, :volume, :float 
  end
end
