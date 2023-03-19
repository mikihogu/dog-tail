class AddVisitorToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :visitor_id, :integer, null: false
    add_column :notifications, :visited_id, :integer, null: false
  end
end
