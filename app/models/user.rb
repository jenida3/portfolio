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
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  # パスワードリセットのためのトークン生成とメール送信
  def deliver_reset_password_instructions!
    generate_reset_password_token!  # トークン生成
    save!  # 保存
    UserMailer.reset_password_instructions(self).deliver_now  # メール送信
  end

  # リセットトークン生成メソッド
  def generate_reset_password_token!
    self.reset_password_token = SecureRandom.urlsafe_base64(64)  # トークンを生成
    self.reset_password_token_expires_at = 2.hours.from_now  # 有効期限設定
    self.reset_password_email_sent_at = Time.current  # メール送信時刻
    save!
  end
end

