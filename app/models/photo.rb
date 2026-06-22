class Photo < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validate :image_present_and_valid

  CONTENT_TYPES = %w[image/png image/jpeg image/jpg image/webp image/gif].freeze

  private

  def image_present_and_valid
    unless image.attached?
      errors.add(:image, "é obrigatória")
      return
    end
    unless image.content_type.in?(CONTENT_TYPES)
      errors.add(:image, "deve ser uma imagem (PNG, JPG, WEBP ou GIF)")
    end
  end
end
