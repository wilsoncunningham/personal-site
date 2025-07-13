class RemoveDateReadFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :date_read, :string
  end
end
