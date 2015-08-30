class DegreeType < ActiveRecord::Base
  has_many :degrees, :dependent => :restrict
  validates :degree_type_name, :presence => true

  default_scope -> { order('degree_type_name ASC') }

  searchable do
    text :degree_type_name  
    text :degree_type_notes 
    string :degree_type_name_sortable do 
      degree_type_name
    end
  end

end
