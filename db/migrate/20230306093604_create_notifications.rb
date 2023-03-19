class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :comment_id, null: false
      t.integer :post_id, null: false
      t.boolean :checked, null: false, dafault: false
      t.timestamps
    end
  end
end
