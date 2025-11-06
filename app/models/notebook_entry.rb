# == Schema Information
#
# Table name: notebook_entries
#
#  id         :bigint           not null, primary key
#  content    :text
#  entry_type :string
#  image_url  :string
#  is_pinned  :boolean          default(FALSE)
#  is_public  :boolean          default(TRUE)
#  link_url   :string
#  tags       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NotebookEntry < ApplicationRecord
end
