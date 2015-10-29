class AddPrimaryToDegreesUsers < ActiveRecord::Migration
  def change
    add_column :degrees_users, :primary, :boolean
  end
end
