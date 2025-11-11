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
  # single attachment via Active Storage
  has_one_attached :image, dependent: :purge_later

  default_scope { order(position: :asc) }  # keeps gallery ordered

  # Return variants without forcing processing here. Avoid calling
  # `.processed` in the request path so variant generation can be
  # handled asynchronously (reduces memory and CPU pressure during
  # web requests). Views/helpers can call `url_for(photo.thumbnail)`
  # — Active Storage will lazily generate the variant when requested
  # or via a background worker.
  def thumbnail
    image.variant(resize_to_limit: [900, 900]) if image.attached?
  end

  def display
    image.variant(resize_to_limit: [1200, 1200]) if image.attached?
  end

end
