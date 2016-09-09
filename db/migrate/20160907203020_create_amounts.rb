class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.integer :price

      t.timestamps null: false
    end
  end
end
