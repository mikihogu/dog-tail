class Notification < ApplicationRecord

  belongs_to :post
  belongs_to :comment
  belongs_to :visitor, class_name: 'Member', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'Member', foreign_key: 'visited_id'

end
