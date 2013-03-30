class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    # @inclusion = Inclusion.new
    @ingredient = Ingredient.new
  end
  
  def create
    logger.debug "PARAMS!!! #{params}"
    @recipe = Recipe.new(name: params[:recipe][:name],
                         description: params[:recipe][:description],
                         instructions: params[:recipe][:instructions])
    if @recipe.save
      params[:recipe][:ingredients].each do |key, value|
        name = value.downcase
        @ingredient = Ingredient.find_by_name(name)
        if @ingredient
          @inclusion = Inclusion.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
          @inclusion.save ? redirect_to @recipe : render 'new'
        else
          @ingredient = @recipe.ingredients.build(name: name)
          if @ingredient.save
            @inclusion = Inclusion.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
            @inclusion.save ? redirect_to @recipe : render 'new'
          else
            render 'new'
          end
        end
      end
      # params[:recipe][:inclusion].each do |key, value|
      #   name = value.downcase
      #   @ingredient = Ingredient.find_by_name(name)
      #   unless @ingredient
      #     @ingredient = Ingredient.new(name: name)
      #     if @ingredient.save
      #       logger.debug "SAVED INGREDIENT #{@ingredient.name}"
      #     else
      #       logger.debug "INVALID INGREDIENT NAME: #{@ingredient.name}"
      #       flash[:ingredient_name_error] = "Invalid ingredient name format."
      #     end
      #   end
      #   logger.debug "FOUND INGREDIENT! #{@ingredient.inspect}"
      #   @inclusion = Inclusion.new(recipe_id: @recipe.id, ingredient_id: @ingredient.id)
      #   if @inclusion.save
      #     logger.debug "SAVED INCLUSION! #{@inclusion.inspect}"
      #     redirect_to @recipe
      #   else
      #     render 'new'
      #   end
      # end
    else
      render 'new'
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
