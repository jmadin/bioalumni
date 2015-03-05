class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  belongs_to :career

  validates :career, :presence => true
  
  default_scope -> { order('record_date ASC') }

  def self.search(search)
      if search
        where('position_title LIKE ? OR company_name LIKE ?', "%#{search}%", "%#{search}%")
      else
        all
      end
  end

end
