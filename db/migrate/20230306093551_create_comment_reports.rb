class CreateCommentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_reports do |t|

      t.timestamps
    end
  end
end
