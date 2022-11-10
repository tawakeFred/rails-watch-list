class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :comment, presence: true, length: { minimum: 6 }
  validates :list_id, presence: true, uniqueness: {
    scope: [ :movie_id, :list_id ]
  }
end
