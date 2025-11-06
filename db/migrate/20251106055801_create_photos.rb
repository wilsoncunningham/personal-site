class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :caption
      t.string :tag
      t.integer :position

      t.timestamps
    end
  end
end
