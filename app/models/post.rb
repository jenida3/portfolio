class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # いいねの関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # バリデーション (任意)
  validates :content, presence: true, length: { maximum: 300 } # 投稿内容の例
end
