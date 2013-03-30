require 'spec_helper'

describe Ingredient do
  
  before do
    @ingredient = Ingredient.new(name: "test")
  end
  
  subject { @ingredient }
  
  it { should respond_to(:name) }

  it { should be_valid }
  
  describe "when name is not present" do
    before { @ingredient.name = "" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @ingredient.name = "a"*41 }
    it { should_not be_valid }
  end
  
  describe "when name is a duplicate" do
    before do
      duplicate_ingredient = @ingredient.dup
      duplicate_ingredient.save
    end
    it { should_not be_valid }
  end
  
  describe "when name is uppercase" do
    before { @ingredient.name = "EGGS" }
    it { should_not be_valid }
  end
  
  describe "when name format is invalid" do
      it "should be invalid" do
        names = ["HAM", "\"cool food\"", "$weet $@uce!"]
        names.each do |invalid_names|
          @ingredient.name = invalid_names
          @ingredient.should_not be_valid
        end      
      end
    end

    describe "when name format is valid" do
      it "should be valid" do
        names = ["honey-baked ham", "mrs. dash", "newman's own"]
        names.each do |valid_names|
          @ingredient.name = valid_names
          @ingredient.should be_valid
        end      
      end
    end
end
