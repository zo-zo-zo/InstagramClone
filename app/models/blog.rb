class Blog < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user
  mount_uploader :picture, PictureUploader
end
