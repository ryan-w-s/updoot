class Doot < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id, message: "can only doot a post once" }
  validates :value, inclusion: { in: [-1, 1], message: "must be either an updoot (1) or downdoot (-1)" }

  scope :updoots, -> { where(value: 1) }
  scope :downdoots, -> { where(value: -1) }
end
