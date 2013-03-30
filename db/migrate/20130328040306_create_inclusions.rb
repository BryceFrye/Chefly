class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.integer :recipe_id, null: false
      t.integer :ingredient_id, null: false
      t.string :amount, null: false, default: ""
      t.timestamps
    end
  end
end
