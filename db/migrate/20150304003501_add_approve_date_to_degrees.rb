class AddApproveDateToDegrees < ActiveRecord::Migration
  def change
    add_column :degrees, :approval_year, :date
  end
end
