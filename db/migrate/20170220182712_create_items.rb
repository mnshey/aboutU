class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :item_number
     

      t.timestamps
    end
  end
end
