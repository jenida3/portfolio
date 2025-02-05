class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # いいねの関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 画像アップロード機能を追加
  has_one_attached :image

  # バリデーション (任意)
  validates :content, presence: true, length: { maximum: 300 } # 投稿内容の例
end

