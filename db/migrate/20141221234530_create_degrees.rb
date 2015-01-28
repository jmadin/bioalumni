class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.references :user, index: true
      t.references :alum, index: true
      t.string :degree_name
      t.date :graduation_year
      t.string :thesis_title
      t.text :degree_notes

      t.timestamps
    end
  end
end
