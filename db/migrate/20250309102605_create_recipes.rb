class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :cuisine
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.references :category, null: false, foreign_key: true
      t.string :author
      t.string :image

      t.timestamps
    end
  end
end
