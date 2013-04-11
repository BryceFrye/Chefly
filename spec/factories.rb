FactoryGirl.define do
  factory :user do
    name     "test"
    email    "test@test.com"
    password "foobar"
    password_confirmation "foobar"
  end
end