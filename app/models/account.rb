require 'digest'

class Account < ActiveRecord::Base
  include Planlove::AccountExtension
  include PlanView::AccountExtension
  include Theme::AccountExtension

  has_one :plan

  def self.shown
    where { hidden == false }
  end

  def self.[](name)
    shown.find_by_login(name.to_s)
  end

  def password=(pw)
    self.temporary_password = false
    self.password_type = 'scrypt'
    self.crypted_password = SCrypt::Password.create(pw).to_s
  end

  def correct_password?(pw)
    case password_type
    when 'scrypt'
      SCrypt::Password.new(self.crypted_password) == pw
    when 'sha2'
      result = self.crypted_password == hash_password(pw)

      # rehash if the login was successful
      if result
        self.update_attributes(password: pw)
      end

      result
    end
  end

  def handle
    "@#{login}"
  end

  def temporary_password!
    pw = SecureRandom.urlsafe_base64(4)
    self.password = pw
    self.temporary_password = true

    return pw
  end

  # stub, for form helpers
  def password
    ''
  end

  def guest?
    !persisted?
  end

  def logged_in?
    !guest?
  end

  # DEPRECATED
  def hash_password(pw)
    Digest::SHA2.hexdigest("--#{self.salt}--#{pw}--")
  end

private
  before_validation :setup, :on => :create
  def setup
    self.plan ||= build_plan
  end
end
