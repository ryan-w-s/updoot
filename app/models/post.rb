class Post < ApplicationRecord
  belongs_to :user
  belongs_to :collection
  has_many :doots, dependent: :destroy
  has_many :dooters, through: :doots, source: :user

  validates :title, presence: true
  validates :content, presence: true

  # Add Kaminari pagination
  paginates_per 10

  def doot_total
    doots.sum(:value)
  end

  def updoot_count
    doots.updoots.count
  end

  def downdoot_count
    doots.downdoots.count
  end
end
