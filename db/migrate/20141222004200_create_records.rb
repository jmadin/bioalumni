class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, index: true
      t.references :alum, index: true
      t.references :career, index: true
      t.string :work_link
      t.string :email
      t.string :phone
      t.text :record_notes

      t.timestamps
    end
  end
end
