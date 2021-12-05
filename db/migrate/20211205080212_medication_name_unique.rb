class MedicationNameUnique < ActiveRecord::Migration[6.1]
  def change
    add_index :medications, :name, unique: true
    add_index :medications, :code, unique: true
  end
end
