class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 200 }
  validates :status, presence: true
end

def feed_posts_pos
  @users_pos = User.where(mind: "positive")
  Post.where(user_id: @users_pos.ids)
end

def feed_posts_neg
  @users_neg = User.where(mind: "negative")
  Post.where(user_id: @users_neg.ids)
  
end