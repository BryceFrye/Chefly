require 'spec_helper'

describe Recipe do
  
  before do
    @recipe = Recipe.new(name: "Test", description: "A great meal.", instructions: "Cook it.")
  end
  
  subject { @recipe }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:instructions) }

  it { should be_valid }
  
  describe "when name is not present" do
    before { @recipe.name = "" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @recipe.name = "a"*41 }
    it { should_not be_valid }
  end
  
  describe "when description is not present" do
    before { @recipe.description = "" }
    it { should_not be_valid }
  end
  
  describe "when description is too long" do
    before { @recipe.description = "a"*141 }
    it { should_not be_valid }
  end
  
  describe "when instructions is not present" do
    before { @recipe.instructions = "" }
    it { should_not be_valid }
  end
  
  describe "when instructions are too long" do
    before { @recipe.instructions = "a"*1001 }
    it { should_not be_valid }
  end
  
  # describe "when unauthorized user tries to update" do
  #   before do
  #     @user = User.new(email: "test@test.com", password: "foobar",
  #                      password_confirmation: "foobar")
  #     @recipe = @user.recipes.new(name: "Test", description: "A great meal.",
  #                                 instructions: "Cook it.")
  #   end
  # end
end
