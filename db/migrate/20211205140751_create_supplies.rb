class CreateSupplies < ActiveRecord::Migration[6.1]
  def change
    create_table :supplies do |t|
      t.integer :count
      t.references :medications, null: false, foreign_key: true
      t.references :cargo, null: false, foreign_key: true
    end
  end
end
