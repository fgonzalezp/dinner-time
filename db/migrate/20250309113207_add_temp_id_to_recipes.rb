class AddTempIdToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :temp_id, :string
  end
end
