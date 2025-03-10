class RecipesController < ApplicationController

  def index
    @tags= tags || []
    @recipes =  if params[:full_match] == "yes"
      Recipe.includes(:ingredients).with_all_ingredients(@tags)
    else
      Recipe.includes(:ingredients).with_any_ingredient(@tags)
    end

    @records_size = @recipes.count
    @recipes = @recipes.paginate(page: params[:page], per_page: 9)

    respond_to do |format|
      format.html
    end
  end

  private

  def tags
    return if params["tags"].blank?

    JSON.parse(params["tags"].to_s).map { |k| k["value"] }
  end
end
