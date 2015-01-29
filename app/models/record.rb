class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  belongs_to :career
  
  default_scope -> { order('record_date ASC') }
end
