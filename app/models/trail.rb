class Trail < ApplicationRecord
  belongs_to :user
  has_many :video_contents, dependent: :destroy
  has_many :reviews, dependent: :destroy
  CATEGORIES = ["gastronomia"]
  validates :category, presence: true, inclusion: { in: CATEGORIES.map { |category| category.capitalize }}
end
