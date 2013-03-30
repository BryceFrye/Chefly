require 'spec_helper'

describe Inclusion do
  
  before do
    @inclusion = Inclusion.new(recipe_id: 1, ingredient_id: 1)
  end
  
  subject { @inclusion }
  
  it { should respond_to(:recipe_id) }
  it { should respond_to(:ingredient_id) }

  it { should be_valid }
  
  describe "when recipe id is not present" do
    before { @inclusion.recipe_id = "" }
    it { should_not be_valid }
  end
  
  describe "when ingredient id is not present" do
    before { @inclusion.ingredient_id = "" }
    it { should_not be_valid }
  end
end
