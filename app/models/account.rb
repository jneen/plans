require 'digest'

class Account < ActiveRecord::Base
  has_one :plan

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

  alias plan_without_default plan 
  def plan
    return plan_without_default if plan_without_default.present?
    self.plan = Plan.new(account: self)
  end

  def guest?
    !persisted?
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
end
