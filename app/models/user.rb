class User < ActiveRecord::Base
  attr_accessor :login
  has_many :registered_applications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR email = :value", { value: login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

  validates :username, presence: true, uniqueness: {case_sensitive: true}, length: {minimum: 6}
  validates_format_of :username, with: /\A[a-zA-Z0-9_\.]*\z/
  validate :validate_username

  private
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
