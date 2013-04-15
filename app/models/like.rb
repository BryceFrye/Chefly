class Like < ActiveRecord::Base
  attr_accessible :user_id, :recipe_id
  
  belongs_to :user
  belongs_to :recipe
  
  validates :user_id, presence: true
  validates :recipe_id, presence: true
end
