class Blog < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :picture, PictureUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
