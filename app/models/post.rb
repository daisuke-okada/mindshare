class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 200 }
  validates :status, presence: true
end
