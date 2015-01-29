class AddPositionTitleToRecords < ActiveRecord::Migration
  def change
    add_column :records, :position_title, :string
  end
end
