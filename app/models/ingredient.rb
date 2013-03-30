class Ingredient < ActiveRecord::Base
  attr_accessible :name
  
  before_save { |ingredient| ingredient.name = ingredient.name.downcase }
  
  has_many :inclusions
  has_many :recipes, through: :inclusions
  
  validates :name, presence: true, 
                   length: { maximum: 40 }, 
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[ a-z0-9\-\'\.]+\z/ }
                   
  # def self.create_or_find_ingredient(ingredient_name)
  #   @ingredient = Ingredient.find_by_name(ingredient_name)
  #   @ingredient ||= Ingredient.new(name: ingredient_name)
  #   if @ingredient.save
  #     logger.debug "SAVED INGREDIENT #{@ingredient.name}"
  #     @ingredient
  #   end
  # end
  
end
