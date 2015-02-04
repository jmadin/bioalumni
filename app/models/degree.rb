class Degree < ActiveRecord::Base
  # belongs_to :user
  belongs_to :alum
  belongs_to :degree_type
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true

  validates :degree_type, :presence => true
  
  default_scope -> { order('graduation_year ASC') }
end
