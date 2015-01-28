class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.references :user, index: true
      t.string :career_name
      t.string :career_type
      t.string :career_system
      t.text :career_notes

      t.timestamps
    end
  end
end
