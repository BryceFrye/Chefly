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
                   
  def self.create_or_find(params, recipe)
    params[:recipe][:ingredients_attributes].each do |key, value|
      name = value[:ingredient].downcase
      amount = value[:amount]
      next if name.blank?
      @ingredient = Ingredient.find_by_name(name)
      unless @ingredient
        @ingredient = recipe.ingredients.build(name: name)
        render :new unless @ingredient.save
      end
      @inclusion = Inclusion.new(recipe_id: recipe.id,
                                 ingredient_id: @ingredient.id,
                                 amount: amount)
      true if @inclusion.save
    end
  end
  
end
