class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.string :instructions, null: false, default: ""
      t.timestamps
    end
  end
end
