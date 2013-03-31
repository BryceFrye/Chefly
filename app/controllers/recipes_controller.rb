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
        @name
        value.each { |k,v| @name = v.downcase }
        next if @name.blank?
        @ingredient = Ingredient.find_by_name(@name)
        if @ingredient
          @inclusion = Inclusion.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
          unless @inclusion.save
            render 'new'
          end
        else
          @ingredient = @recipe.ingredients.build(name: @name)
          if @ingredient.save
            @inclusion = Inclusion.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
            unless @inclusion.save
              render 'new'
            end
          else
            render 'new'
          end
        end
      end
    else
      render 'new'
    end
    redirect_to @recipe
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
    @recipes = []
    ingredient = Ingredient.find_by_name(params[:ingredient])
    if ingredient
      inclusions = Inclusion.where(ingredient_id: ingredient.id)
      if inclusions
        inclusions.each do |inclusion|
          if recipe = Recipe.find(inclusion.recipe_id)
            logger.debug "RECIPE: #{recipe}"
            @recipes.push(recipe)
          end
        end
      end
    end
    render json: @recipes
  end
end
