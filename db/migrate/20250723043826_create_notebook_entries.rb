class CreateNotebookEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :notebook_entries do |t|
      t.string :title
      t.text :content
      t.string :entry_type
      t.string :link_url
      t.string :image_url
      t.string :tags, array: true, default: []
      t.boolean :is_pinned, default: false
      t.boolean :is_public, default: true

      t.timestamps
    end
  end
end
