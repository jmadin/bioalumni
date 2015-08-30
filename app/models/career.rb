class Career < ActiveRecord::Base
  belongs_to :user
  has_many :records, :dependent => :restrict

  validates :career_name, :presence => true

  default_scope -> { order('career_name ASC') }

  searchable do
    text :career_name  
    text :career_notes 
    text :career_type
    text :career_system
    string :career_name_sortable do 
      career_name
    end
  end

end
