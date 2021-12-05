class MedicationNullFields < ActiveRecord::Migration[6.1]
  def change
    change_column_null :medications, :name, false
    change_column_null :medications, :weight, false
    change_column_null :medications, :code, false
  end
end
