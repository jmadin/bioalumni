class CreateDegreeTypes < ActiveRecord::Migration
  def change
    create_table :degree_types do |t|
      t.string :degree_type_name
      t.text :degree_type_notes

      t.timestamps
    end
  end
end
