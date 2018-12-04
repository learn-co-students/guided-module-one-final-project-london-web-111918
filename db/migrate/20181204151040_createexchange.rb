class Createexchange < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.string :name
    end
  end
end
