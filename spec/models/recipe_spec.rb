require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:category) { Category.create(name: "Dessert") }
  let!(:recipe1) { Recipe.create(title: "Cake", category: category) }
  let!(:recipe2) { Recipe.create(title: "Bread", category: category) }
  let!(:ingredient1) { Ingredient.create(name: "flour", recipe: recipe1) }
  let!(:ingredient2) { Ingredient.create(name: "sugar", recipe: recipe1) }
  let!(:ingredient3) { Ingredient.create(name: "flour", recipe: recipe2) }

  describe ".with_all_ingredients" do
    it "returns recipes containing all specified ingredients" do
      expect(Recipe.with_all_ingredients("flour,sugar")).to include(recipe1)
      expect(Recipe.with_all_ingredients("flour,sugar")).not_to include(recipe2)
    end

    it "returns all recipes if ingredient_terms is blank" do
      expect(Recipe.with_all_ingredients(nil)).to include(recipe1, recipe2)
      expect(Recipe.with_all_ingredients("")).to include(recipe1, recipe2)
    end

    it "is case-insensitive and handles whitespace" do
      expect(Recipe.with_all_ingredients(" FLOUR , sugar ")).to include(recipe1)
    end
  end

  describe ".with_any_ingredient" do
    it "returns recipes containing any of the specified ingredients" do
      expect(Recipe.with_any_ingredient("flour")).to include(recipe1, recipe2)
      expect(Recipe.with_any_ingredient("sugar")).to include(recipe1)
      expect(Recipe.with_any_ingredient("sugar")).not_to include(recipe2)
    end

    it "returns all recipes if ingredient_terms is blank" do
      expect(Recipe.with_any_ingredient(nil)).to include(recipe1, recipe2)
      expect(Recipe.with_any_ingredient("")).to include(recipe1, recipe2)
    end
  end

  describe "#formatted_ingredients" do
    it "returns a comma-separated list of ingredient names" do
      expect(recipe1.formatted_ingredients).to eq("flour, sugar")
      expect(recipe2.formatted_ingredients).to eq("flour")
    end

    it "returns an empty string if there are no ingredients" do
      new_recipe = Recipe.create(title: "Empty", category: category)
      expect(new_recipe.formatted_ingredients).to eq("")
    end
  end
end
