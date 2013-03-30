class Inclusion < ActiveRecord::Base
  attr_accessible :ingredient_id, :recipe_id
  # attr_accessor :ingredient
  
  belongs_to :recipe
  belongs_to :ingredient
  
  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true
  
  # def self.create_inclusion(params, recipe)
  #   params.each do |key, value|
  #     @ingredient = Ingredient.create_or_find_ingredient(value.downcase)
  #     if @ingredient
  #       logger.debug "FOUND INGREDIENT! #{@ingredient.inspect}"
  #       @inclusion = Inclusion.new(recipe_id: recipe.id, ingredient_id: @ingredient.id)
  #       if @inclusion.save
  #         logger.debug "FOUND @inclusion! #{@inclusion.inspect}"
  #         @inclusion
  #       else
  #         false
  #       end
  #     else
  #       logger.debug "Coult neot FOUND INGREDIENT!"
  #       return false
  #     end
  #   end
  # end
  
end
