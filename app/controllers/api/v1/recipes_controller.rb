class Api::V1::RecipesController < ApplicationController
  def index
    recipe = Recipe.all.order(created_at: :desc)
    render json: recipe
  end

  def create
    recipe = Recipe.create!(recipe_params)
    if recipes
      render json: recipe
    else
      render json: recipe.errors
    end
  end

  def show
    if find_recipe
      render json: recipe
    else
      render json: recipe.errors
    end
  end

  def destroy
    recipe&.destroy
    render json: { message: 'Recipe deleted!' }
  end

  private

  def recipe_params
    params.permit(:name, :image, :ingredients, :instructions)
  end

  def find_recipe
    @find_recipe ||= Recipe.find(params[:id])
  end
end
