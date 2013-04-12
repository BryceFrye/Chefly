class Recipe < ActiveRecord::Base
  attr_accessible :name, :description, :instructions
  
  has_many :inclusions, dependent: :destroy
  has_many :ingredients, through: :inclusions
  belongs_to :user
  
  accepts_nested_attributes_for :ingredients
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :instructions, presence: true, length: { maximum: 2000 }
  
  def self.populate_ingredient_names(ingredients)
    ingredient_names = {}
    ingredients.each do |ingredient|
      ingredient_names[ingredient] = true unless ingredient.blank?
    end
    ingredient_names
  end
  
  def self.check_for_ingredient(ingredients)
    ingredients_in_bd = []
    ingredients.each do |ingredient, value|
      ingredient_to_add = Ingredient.find_by_name(ingredient)
      ingredients_in_bd.push(ingredient_to_add) if ingredient_to_add
    end
    ingredients_in_bd
  end
  
  def self.get_possible_recipes(ingredients)
    possible_recipes = {}
    ingredients.each do |ingredient|
      ingredient.recipes.each { |recipe| possible_recipes[recipe.id] = recipe }
    end
    possible_recipes
  end
  
  def self.check_possibe_recipes(possible_recipes, ingredient_names)
    recipes = []
    possible_recipes.each do |key, recipe|
      recipe_is_match = true
      recipe.ingredients.each do |ingredient|
        unless ingredient_names.has_key?(ingredient.name)
          recipe_is_match = false
          break
        end
      end
      recipes.push(recipe) if recipe_is_match
    end
    recipes
  end
  
end
