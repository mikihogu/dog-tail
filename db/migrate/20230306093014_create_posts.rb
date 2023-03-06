class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id, null: false
      t.integer :category_id, null: false
      t.string :name, null: false
      t.string :introduction, null: false
      t.text :information, null: false
      t.string :prefecture, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end
  end
end
