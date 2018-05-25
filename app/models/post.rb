class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true, length: { maximum:140 }
  validates :title, presence: true, length: { maximum:65 }
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
end
