class Collection < ApplicationRecord
    has_many :moderators, dependent: :destroy
    has_many :mods, through: :moderators, source: :user
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9 ]+\z/ }

    def moderator?(user)
        mods.include?(user)
    end
end
