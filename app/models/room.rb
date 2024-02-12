class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :room_name, presence: true
  validates :room_introduction, presence: true
  validates :price,  numericality: { only_integer: true, greater_than_or_equal_to: 1}
  validates :address, presence: true

  mount_uploader :room_image, ImageUploader
end
