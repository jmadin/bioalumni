class Career < ActiveRecord::Base
  belongs_to :user
  has_many :records

  default_scope -> { order('career_name ASC') }

end
