class AddDegreeTypeToDegrees < ActiveRecord::Migration
  def change
    add_reference :degrees, :degree_type, index: true
    remove_column :degrees, :degree_name
  end
end
