class Collection < ApplicationRecord
    has_many :moderators, dependent: :destroy
    has_many :mods, through: :moderators, source: :user
    has_many :posts, dependent: :destroy
    has_many :watchers, dependent: :destroy
    has_many :watching_users, through: :watchers, source: :user
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9 ]+\z/ }

    def moderator?(user)
        mods.include?(user)
    end

    def watched_by?(user)
        watching_users.include?(user)
    end
end
