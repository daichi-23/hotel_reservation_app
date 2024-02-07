class Room < ApplicationRecord
  belongs_to :user

  validates :room_name, presence: true
  validates :room_introduction, presence: true
  validates :price,  numericality: true, length: {minimum: 1}
  validates :address, presence: true

  mount_uploader :room_image, ImageUploader
end
