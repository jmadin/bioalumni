class ChangePrimaryInDegreesUsers < ActiveRecord::Migration
  def change
    rename_column :degrees_users, :primary, :primary_supervisor
  end
end
