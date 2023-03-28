class Comment < ApplicationRecord
  
  validates :comment, presence: true, length: { maximum: 50 }
  
  belongs_to :member
  belongs_to :post
  has_one :notification, dependent: :destroy
  
end
