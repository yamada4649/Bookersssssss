class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :followers, source: :followed # 自分がフォローしている人
has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  attachment :profile_image
 validates :name,presence: true, length: { minimum: 2, maximum: 20 } #lengthの書き方でうまくいかない可能性あり。in..を使う。validateは一番下に書くべし。
 validates :introduction, length: { maximum: 50 }
def follow(user_id)#ここには必ずidがないといけない。
  followers.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  followers.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end

end
