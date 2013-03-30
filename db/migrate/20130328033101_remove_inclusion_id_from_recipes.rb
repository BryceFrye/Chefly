class RemoveInclusionIdFromRecipes < ActiveRecord::Migration
  def up
    remove_column :recipes, :inclusion_id
  end

  def down
  end
end
