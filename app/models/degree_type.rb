class DegreeType < ActiveRecord::Base
  has_many :degrees, :dependent => :restrict
  validates :degree_type_name, :presence => true

  default_scope -> { order('degree_type_name ASC') }

end
