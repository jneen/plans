require 'digest'

class Account < ActiveRecord::Base
  include Planlove::AccountExtension
  include AutoFinger::AccountExtension

  has_one :plan

  def self.[](name)
    find_by_login(name.to_s)
  end

  def password=(pw)
    self.crypted_password = hash_password(pw)
  end

  def salt
    self[:salt] ||= generate_salt
  end

  def correct_password?(pw)
    self.crypted_password == hash_password(pw)
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

private
  def hash_password(pw)
    hash_string("--#{self.salt}--#{pw}--")
  end

  def hash_string(str)
    Digest::SHA2.hexdigest(str)
  end

  def generate_salt(bytes=64)
    ActiveSupport::SecureRandom.base64(bytes)
  end

  before_validation :setup, :on => :create
  def setup
    self.plan ||= build_plan
  end
end
