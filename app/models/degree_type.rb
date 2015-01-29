class DegreeType < ActiveRecord::Base
  has_many :degrees

  default_scope -> { order('degree_type_name ASC') }
end
