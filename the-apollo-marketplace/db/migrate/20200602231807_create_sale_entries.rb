class CreateSaleEntries < ActiveRecord::Migration
  def change
    create_table :sale_entries do |t|
      t.string :item
      t.string :description
      t.integer :price
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
