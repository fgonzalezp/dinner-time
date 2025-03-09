require 'json'

puts "Starting to load data..."
file_path = Rails.root.join('db/recipes_data', 'recipes-en.json')
recipes_data = JSON.parse(File.read(file_path))

bulk_data = []
new_ingredients = []

recipes_data.each do |recipe|
  category_name = recipe["category"].presence || "Uncategorized"
  category = Category.find_or_create_by(name: category_name)
  temp_id = SecureRandom.uuid

  new_recipe = {
    title: recipe["title"],
    cook_time: recipe["cook_time"],
    prep_time: recipe["prep_time"],
    ratings: recipe["ratings"],
    cuisine: recipe["cuisine"].presence,
    author: recipe["author"],
    image: recipe["image"],
    category_id: category.id,
    temp_id: temp_id
  }

  recipe["ingredients"].each do |ingredient_name|
    new_ingredients << { name: ingredient_name.strip, temp_id: temp_id }
  end
  bulk_data << new_recipe
end

Recipe.insert_all(bulk_data)
puts "Recipe data loaded!"

recipe_id_map = Recipe.pluck(:temp_id, :id).to_h
new_ingredients.each do |ingredient|
  ingredient[:recipe_id] = recipe_id_map[ingredient[:temp_id]]
end

Ingredient.insert_all(new_ingredients.map{ |e| e.except(:temp_id) })

puts "Seeding complete!"
