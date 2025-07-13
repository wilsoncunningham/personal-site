class AddStartDateAndEndDateToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :start_date, :date
    add_column :books, :end_date, :date
  end
end
