class MakeDegreeUserTable < ActiveRecord::Migration
  def change

    create_table :degrees_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :degree
    end

  end
end
