class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :recipe_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :likes, :recipe_id
    add_index :likes, :user_id
  end
end
