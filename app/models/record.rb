class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  belongs_to :career

  validates :career, :presence => true
  
  default_scope -> { order('record_date ASC') }

  searchable do
    text :work_link  
    text :email  
    text :work_link  
    text :phone 
    text :record_notes 
    text :position_title 
    text :company_name 
  end

end

