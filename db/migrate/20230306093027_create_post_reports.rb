class CreatePostReports < ActiveRecord::Migration[6.1]
  def change
    create_table :post_reports do |t|

      t.integer :comment_id, null: false
      t.integer :member_id, null: false
      t.text :reason, null: false
      t.timestamps
    end
  end
end
