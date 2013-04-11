class RecipesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_filter :authorized_user, only: [:edit, :update]
  
  def new
    @recipe = Recipe.new
    5.times { @recipe.ingredients.build }
  end
  
  def create
    instructions = Recipe.nl_to_br(params[:recipe][:instructions])
    @recipe = current_user.recipes.build(name: params[:recipe][:name],
                                         description: params[:recipe][:description],
                                         instructions: instructions)
    if @recipe.save
      if Ingredient.create_or_find(params, @recipe)
        redirect_to @recipe
      else
        render :new
      end
    else
      render :new
    end
  end
  
  def index
    # @recipes = Recipe.limit(10).order("created_at desc")
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe
    else
      render 'edit'
    end
  end
  
  def search
    input_ingredients = params[:ingredient].split("_")
    ingredient_names = Recipe.populate_ingredient_names(input_ingredients)
    ingredients_in_db = Recipe.check_for_ingredient(ingredient_names)
    possible_recipes = Recipe.get_possible_recipes(ingredients_in_db)
    @recipes = Recipe.check_possibe_recipes(possible_recipes, ingredient_names)
    render json: @recipes
  end
  
  def update_ingredient_cookies
    cookies[:ingredients] = []
    @ingredients = params[:ingredient].split("_")
    logger.debug "@ingredients: #{@ingredients}"
    @ingredients.each do |ingredient|
      cookies[:ingredients].push(ingredient)
    end
    render nothing: true
  end
  
  private
    def authorized_user
      @recipe = Recipe.find(params[:id])
      unless (@recipe.user == current_user) || current_user.admin
        redirect_to root_path
      end
    end
end