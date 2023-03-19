class AddRecheckToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :recheck, :boolean, default: false, null: false
  end
end
