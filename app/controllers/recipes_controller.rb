class RecipesController < ApplicationController

  def index
    @recipes = Recipe.includes(:ingredients).paginate(page: params[:page], per_page: 12)
  end
end
