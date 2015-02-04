class DropUserFromDegrees < ActiveRecord::Migration
  def change
    remove_column :degrees, :user_id
  end
end
