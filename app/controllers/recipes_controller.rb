class RecipesController < ApplicationController
  
  def new
    @recipe = Recipe.new
    5.times { @recipe.ingredients.build }
  end
  
  def create
    @recipe = Recipe.new(name: params[:recipe][:name],
                         description: params[:recipe][:description],
                         instructions: params[:recipe][:instructions])
    if @recipe.save
      params[:recipe][:ingredients_attributes].each do |key, value|
        name = value[:ingredient].downcase
        amount = value[:amount]
        next if name.blank?
        @ingredient = Ingredient.find_by_name(name)
        unless @ingredient
          @ingredient = @recipe.ingredients.build(name: name)
          redirect_to :new unless @ingredient.save
        end
        @inclusion = Inclusion.new(recipe_id: @recipe.id,
                                   ingredient_id: @ingredient.id,
                                   amount: amount)
        redirect_to :new unless @inclusion.save
      end
      redirect_to @recipe
    else
      render :new
    end
  end
  
  def index
    @recipes = Recipe.limit(10).order("created_at desc")
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def search
    input_ingredients = params[:ingredient].split("_")
    ingredient_names = Recipe.populate_ingredient_names(input_ingredients)
    ingredients_in_db = Recipe.check_for_ingredient(ingredient_names)
    possible_recipes = Recipe.get_possible_recipes(ingredients_in_db)
    @recipes = Recipe.check_possibe_recipes(possible_recipes, ingredient_names)
    render json: @recipes
  end
end
