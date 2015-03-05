class Alum < ActiveRecord::Base
  belongs_to :user
  has_many :degrees
  has_many :records
  has_many :photos

  validates :first_name, :presence => true
  validates :last_name, :presence => true, :uniqueness => {:scope => [:first_name, :middle_name], :message => "and first name combination already exists. If this is indeed correct, please add a middle name to distinguish between the two people."} 


  acts_as_taggable

  def self.search(search)
      if search
        where('mq_id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR alum_notes LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      else
        all
      end
  end
  
end
