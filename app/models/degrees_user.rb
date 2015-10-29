class DegreesUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :degree

end

    # t.integer  "alum_id"
    # t.date     "graduation_year"
    # t.string   "thesis_title"
    # t.text     "degree_notes"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.integer  "degree_type_id"
    # t.date     "approval_year"
