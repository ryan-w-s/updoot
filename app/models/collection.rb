class Collection < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9 ]+\z/ }
end
