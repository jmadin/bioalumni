class CreateAlums < ActiveRecord::Migration
  def change
    create_table :alums do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :sex
      t.date :dob
      t.string :mq_id
      t.text :alum_notes

      t.timestamps
    end
  end
end
