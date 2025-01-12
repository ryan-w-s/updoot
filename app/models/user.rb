class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    has_many :moderators, dependent: :destroy
    has_many :moderates, through: :moderators, source: :collection
    has_many :watchers, dependent: :destroy
    has_many :watched_collections, through: :watchers, source: :collection
    has_many :doots, dependent: :destroy
    has_many :dooted_posts, through: :doots, source: :post
  
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true, format: {with: /\A[a-zA-Z0-9]+\Z/}

  def watching?(collection)
    watched_collections.include?(collection)
  end

  def doot_value_for(post)
    doots.find_by(post: post)&.value
  end
end
