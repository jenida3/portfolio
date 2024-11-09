class Game < ApplicationRecord
  has_many :posts, dependent: :destroy  # ゲームが削除されたときにポストも削除
end
