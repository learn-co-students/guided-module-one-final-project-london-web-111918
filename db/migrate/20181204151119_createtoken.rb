class Createtoken < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :name
      t.string :slug
      t.float :rate
    end
  end
end
