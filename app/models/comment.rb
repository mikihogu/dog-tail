class Comment < ApplicationRecord
  
  belongs_to :member
  belongs_to :post
  has_one :notification, dependent: :destroy
  
end
