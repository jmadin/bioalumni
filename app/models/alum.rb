class Alum < ActiveRecord::Base
  belongs_to :user
  has_many :degrees
  has_many :records
  has_many :photos

  acts_as_taggable

  def self.search(search)
      if search
        where('first_name LIKE ? OR last_name LIKE ? OR alum_notes LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
      else
        all
      end
  end

end
