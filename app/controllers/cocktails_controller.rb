class CocktailsController < ApplicationController

  def index 
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = current_user.cocktails.build params[:cocktail]
    if @cocktail.save
      redirect_to @cocktail
    else
      render :new
    end
  end

  def edit
    @cocktail.find(params[:id])
  end

  def update
  end

  def destroy
    Cocktail.destroy(params[:id])
    render :nothing => true
  end

  def search

    selected_ingredient_names = []
    params[:parameters].each do |k, v|
      selected_ingredient_names << k if v == "1"
    end

    selected_ingredients = []
    selected_ingredient_names.each do |name|
      selected_ingredients << Ingredient.find_by_name(name)
    end

    selected_ingredients.flatten!

    cocktail_id_numbers = []
    selected_ingredients.each do |ingredient|
      cocktail_id_numbers << ingredient.cocktail_id unless cocktail_id_numbers.include?(ingredient.cocktail_id)
    end

    @cocktails = Cocktail.find(cocktail_id_numbers)
  end
end
