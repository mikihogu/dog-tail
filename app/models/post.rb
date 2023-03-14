class Post < ApplicationRecord

  validates :name, presence: true
  validates :introduction, presence: true
  validates :information, presence: true
  validates :post_image, presence: true
  validates :category, presence: true
  # validates :tag, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  belongs_to :member
  belongs_to :category
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :post_image
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def get_post_image
    (post_image.attached?) ? post_image : 'no-image.jpeg'
  end

  def get_image
    (image.attached?) ? image : 'no-image.jpeg'
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def interested_by?(member)
    interests.exists?(member_id: member.id)
  end

  # コメント通知機能 ↓
  # 投稿者にのみ通知を送る
  def create_notification_comment!(current_member, comment_id)
    save_notification_comment!(current_member, comment_id, member_id)
  end

  def save_notification_comment!(current_member, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    else
      notification.checked = false
    end
    notification.save if notification.valid?
  end

  # コメント通知ここまで ↑

  # searchs/search
  # def self.looks(word)
  #   Post.where("name LIKE?","%#{word}%")
  # end

  def self.search(keyword)
    prefecture = prefectures.select{|k, v| k =~ /#{keyword}/ }
    Post.where("name LIKE ? OR prefecture IS ?","%#{keyword}%", prefecture.values)
  end

  # enum利用
  enum prefecture:{
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,岐阜県:21,
    静岡県:22,愛知県:23,三重県:24,滋賀県:25,京都府:26,大阪府:27,兵庫県:28,
    奈良県:29,和歌山県:30,鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,福岡県:40,佐賀県:41,長崎県:42,
    熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }

end
