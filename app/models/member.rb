class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :dog, presence: true
  validates :introduction, presence: true

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :comment_reports, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  has_one_attached :image
  has_many_attached :dog_images

  def get_image
    (image.attached?) ? image : 'no-image.jpg'
  end

  def get_dog_images
    (dog_images.attached?) ? dog_images : ['dog-no-image.jpg']
  end

  # 並べ替え
  scope :status, -> { order(is_deleted: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :latest, -> { order(created_at: :desc) }

  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'guestmember', email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.nickname = "ゲストユーザー"
      member.dog = "shiba"
      member.introduction = "hello"
    end
  end

end
