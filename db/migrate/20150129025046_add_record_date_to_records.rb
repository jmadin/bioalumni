class AddRecordDateToRecords < ActiveRecord::Migration
  def change
    add_column :records, :record_date, :date
  end
end
