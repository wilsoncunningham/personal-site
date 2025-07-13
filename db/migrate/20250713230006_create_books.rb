class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :date_read
      t.float :rating
      t.text :notes

      t.timestamps
    end
  end
end
