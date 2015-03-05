class User < ActiveRecord::Base

  has_many :photos, :dependent => :destroy
  # has_many :degrees
  has_and_belongs_to_many :degrees
  accepts_nested_attributes_for :degrees, :reject_if => :all_blank, :allow_destroy => false

  attr_accessor :code

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_presence_of :code, :message => "Ask the HoD for a code"
  has_secure_password
  validates :password, length: { minimum: 6 }

  default_scope -> { order('surname ASC') }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(search)
      if search
        where('name LIKE ? OR surname LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
      else
        all
      end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
