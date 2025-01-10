class Post < ApplicationRecord
  belongs_to :user
  belongs_to :collection
  
  validates :title, presence: true, length: { minimum: 3, maximum: 300 }
  validates :content, presence: true, length: { minimum: 10 }
end
