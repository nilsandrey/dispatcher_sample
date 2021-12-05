class CreateCargos < ActiveRecord::Migration[6.1]
  def change
    create_table :cargos do |t|
      t.boolean :active
      t.references :drone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
