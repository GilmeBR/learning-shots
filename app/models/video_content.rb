class VideoContent < ApplicationRecord
  belongs_to :trail
  validates :video_id, uniqueness: true
end
