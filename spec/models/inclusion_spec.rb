require 'spec_helper'

describe Inclusion do
  
  before do
    @inclusion = Inclusion.new(recipe_id: 1, ingredient_id: 1, amount: "one cup")
  end
  
  subject { @inclusion }
  
  it { should respond_to(:recipe_id) }
  it { should respond_to(:ingredient_id) }
  it { should respond_to(:amount) }

  it { should be_valid }
  
  describe "when recipe id is not present" do
    before { @inclusion.recipe_id = "" }
    it { should_not be_valid }
  end
  
  describe "when ingredient id is not present" do
    before { @inclusion.ingredient_id = "" }
    it { should_not be_valid }
  end
  
  describe "when amount is not present" do
    before { @inclusion.amount = "" }
    it { should_not be_valid }
  end
  
  describe "when recipe is deleted" do
    before do
      @recipe = Recipe.new(name: "Test", description: "A great meal.", instructions: "Cook it.")
      @inclusion.recipe_id = @recipe.id
      @recipe.destroy
    end
    it { should_not be_valid }
  end
end
