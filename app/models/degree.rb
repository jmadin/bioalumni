class Degree < ActiveRecord::Base
  # belongs_to :user
  belongs_to :alum
  belongs_to :degree_type
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true

  validates :degree_type, :presence => true
  
  default_scope -> { order('graduation_year ASC') }

  searchable do
    text :thesis_title  
    text :graduation_year 
    text :degree_notes 
  end

end

    # t.integer  "alum_id"
    # t.date     "graduation_year"
    # t.string   "thesis_title"
    # t.text     "degree_notes"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.integer  "degree_type_id"
    # t.date     "approval_year"
