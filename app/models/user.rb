class User < ApplicationRecord
  authenticates_with_sorcery!

  # 投稿との関連付け
  has_many :posts, dependent: :destroy

  # いいねの関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # バリデーション
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, message: "は6文字以上である必要があります" },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: -> { new_record? || changes[:crypted_password] }
end
