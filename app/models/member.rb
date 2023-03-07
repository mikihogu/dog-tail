class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :image, presence: true
  validates :dog, presence: true
  validates :introduction, presence: true
  validates :dog_images, presence: true

  has_one_attached :image
  has_many_attached :dog_images

  def get_image
    (image.attached?) ? image: 'dog-no-image.jpeg'
  end
  
  def get_dog_images
    (dog_images.attached?) ? image: 'dog-no-image.jpeg'
  end

end
