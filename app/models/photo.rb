# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  caption    :text
#  position   :integer
#  tag        :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ApplicationRecord
  has_one_attached :image, dependent: :purge_later do |a|
    a.variant :thumbnail, resize_to_limit: [900, 900]    # safe, but we won't use this in the grid
    a.variant :display,   resize_to_limit: [1200, 1200]
  end

  default_scope { order(position: :asc) }

  validate :acceptable_image

  def acceptable_image
    return unless image.attached?
    if image.blob.byte_size > 8.megabytes
      errors.add(:image, "is too large (max 8 MB)")
    end
    acceptable_types = %w[image/jpeg image/png image/webp]
    unless acceptable_types.include?(image.blob.content_type)
      errors.add(:image, "must be a JPG, PNG, or WEBP")
    end
  end
end
