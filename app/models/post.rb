class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :content, presence: true, length: { maximum: 140 }
  validates :title, presence: true, length: { maximum: 65 }
  validates :image, presence: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :user
end
