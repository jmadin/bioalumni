class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :alum
  validates :photo_filename, :presence => true
  # validates :tag_list, :presence => true

  acts_as_taggable

  has_attached_file :photograph, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :photograph, :content_type => /\Aimage\/.*\Z/
  # validates_attachment :photograph, :presence => true, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png", "image/tiff", "application/pdf"] }

  validates_attachment_content_type :photograph, :content_type => ["image/jpg", "image/jpeg", "image/png", "application/pdf"]

  # def self.search(search)
  #     if search
  #       where('photo_filename LIKE ? OR photo_notes LIKE ? OR photograph_file_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  #     else
  #       all
  #     end
  # end

  searchable do
    text :photo_filename  
    text :photo_notes 
    text :photograph_file_name 
    string :photo_filename_sortable do 
      photo_filename
    end
  end

end
