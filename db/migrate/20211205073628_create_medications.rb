class CreateMedications < ActiveRecord::Migration[6.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.decimal :weight
      t.string :code
      t.string :image

      t.timestamps
    end
  end
end
