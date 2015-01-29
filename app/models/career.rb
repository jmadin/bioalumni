class Career < ActiveRecord::Base
  belongs_to :user
  has_many :records

  validates :career_name, :presence => true

  default_scope -> { order('career_name ASC') }

end
