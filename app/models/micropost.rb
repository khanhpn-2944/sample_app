class Micropost < ApplicationRecord
  belongs_to :user

  scope :order_time, ->{order(created_at: :desc)}

  validates :content, presence: true,
            length: {maximum: Settings.const.maximum_content_length_140}

  has_one_attached :image
  validates :image, content_type: {in: Settings.const.image_content_type,
                                   message: t("validates.image_content_type")},
            size: {less_than: Settings.const.image_size.megabytes,
                   message: t("validates.image_size")}

  def display_image
    image.variant resize_to_limit: [Settings.const.image_display_resize,
                                    Settings.const.image_display_resize]
  end
end
