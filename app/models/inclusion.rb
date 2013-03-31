class Inclusion < ActiveRecord::Base
  attr_accessible :ingredient_id, :recipe_id
  
  belongs_to :recipe
  belongs_to :ingredient
  
  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true
  
end
