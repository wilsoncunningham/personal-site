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
  has_one_attached :image   # links to Active Storage
  default_scope { order(position: :asc) }  # optional: keeps gallery ordered
end
