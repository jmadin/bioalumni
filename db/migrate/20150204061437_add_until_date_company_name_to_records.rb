class AddUntilDateCompanyNameToRecords < ActiveRecord::Migration
  def change
    add_column :records, :company_name, :string
    add_column :records, :until_date, :date
  end
end
