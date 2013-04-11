require 'spec_helper'

describe User do
  
  before do
    @user = User.new(username: "test",email: "test@test.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  subject { @user }
  
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
  
  describe "when username is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end
  
  describe "when username is too short" do
    before { @user.username = "a" }
    it { should_not be_valid }
  end
  
  describe "when username is too long" do
    before { @user.username = "a"*21 }
    it { should_not be_valid }
  end
  
  describe "when username is taken" do
    before do
      duplicate_user = @user.dup
      duplicate_user.save
    end
    it { should_not be_valid }
  end
  
  describe "when username is taken but with different case" do
    before do
      duplicate_user = @user.dup
      duplicate_user.username = duplicate_user.username.upcase
      duplicate_user.save
    end
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "when a password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                  foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
end
