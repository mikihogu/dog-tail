class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :image, presence: true
  validates :dog, presence: true
  validates :introduction, presence: true

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :interests, dependent: :destroy

  has_one_attached :image
  # has_one_attached :dog_image
  has_many_attached :dog_image

  def get_image
    (image.attached?) ? image : 'no-image.jpeg'
  end
  
  def get_dog_image
    (dog_image.attached?) ? dog_image[0] : 'dog-no-image.jpeg'
  end

  # def get_dog_images
  #   (dog_images.attached?) ? image: 'dog-no-image.jpeg'
  # end

end
