class AddTempIdToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :temp_id, :string
  end
end
