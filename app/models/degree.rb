class Degree < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  belongs_to :degree_type
  
  default_scope -> { order('graduation_year ASC') }
end
