class Degree < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  belongs_to :degree_type
end
