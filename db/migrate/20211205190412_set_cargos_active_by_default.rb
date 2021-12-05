class SetCargosActiveByDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :cargos, :active, true
  end
end
