class Recipe < ActiveRecord::Base
  attr_accessible :name, :description, :instructions
  
  has_many :inclusions, dependent: :destroy
  has_many :ingredients, through: :inclusions
  
  accepts_nested_attributes_for :ingredients
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :instructions, presence: true, length: { maximum: 1000 }
  
end
