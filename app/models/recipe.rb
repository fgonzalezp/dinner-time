class Recipe < ApplicationRecord
  belongs_to :category
  has_many :ingredients

  scope :with_all_ingredients, ->(ingredient_terms) {
    return all if ingredient_terms.blank?

    terms = ingredient_terms.is_a?(Array) ? ingredient_terms : ingredient_terms.split(/\s*,\s*/)
    terms = terms.map(&:strip).reject(&:blank?)

    return all if terms.empty?

    query = self

    terms.each do |term|
      query = query.where(id: Ingredient.where("ingredients.name ILIKE ?", "%#{term}%").select(:recipe_id))
    end

    query
  }

  scope :with_any_ingredient, ->(ingredient_terms) {
    return all if ingredient_terms.blank?

    terms = ingredient_terms.is_a?(Array) ? ingredient_terms : ingredient_terms.split(/\s*,\s*/)
    terms = terms.map(&:strip).reject(&:blank?)

    return all if terms.empty?

    joins(:ingredients).where(
      terms.map { |term| "ingredients.name ILIKE ?" }.join(" OR "),
      *terms.map { |term| "%#{term}%" }
    ).distinct
  }

  def formatted_ingredients
    ingredients.map(&:name).join(", ")
  end
end
