class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_writer :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def login
    @login || self.username || self.email
  end

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  devise :database_authenticatable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
end
