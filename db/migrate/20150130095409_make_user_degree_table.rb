class MakeUserDegreeTable < ActiveRecord::Migration
  def change
    create_table :users_degrees, id: false do |t|
      t.belongs_to :user
      t.belongs_to :degree
    end
  end
end
