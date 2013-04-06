class Ingredient < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :ingredient, :amount
  
  before_save { |ingredient| ingredient.name = ingredient.name.downcase }
  
  has_many :inclusions
  has_many :recipes, through: :inclusions
  
  validates :name, presence: true, 
                   length: { maximum: 40 }, 
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[ a-z0-9\-\'\.]+\z/ }
  
end
