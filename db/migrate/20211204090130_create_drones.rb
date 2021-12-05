class CreateDrones < ActiveRecord::Migration[6.1]
  def change
    create_table :drones do |t|
      t.string :serial_number, limit: 100
      t.integer :model
      t.decimal :weight_limit
      t.integer :battery, :limit => 1
      t.integer :state

      t.timestamps
    end
    add_index :drones, :serial_number, unique: true
    add_index :drones, :state
    add_index :drones, :model
  end
end
