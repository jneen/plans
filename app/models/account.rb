require 'digest'

class Account < ActiveRecord::Base
  has_one :plan

  has_many :auto_finger_relations, :class_name => 'AutoFinger'
  has_many :auto_fingers,
    :through => :auto_finger_relations,
    :class_name => 'Account',
    :source => :fingered

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

  alias plan_without_default plan 
  def plan
    return plan_without_default if plan_without_default.present?
    self.plan = Plan.new(account: self)
  end

  def guest?
    !persisted?
  end

  def logged_in?
    !guest?
  end

  def fingers
    # TODO: fix the n+1 problem here
    auto_fingers.select { |af| fingering_for(af).viewed_at < af.plan.updated_at }
  end

  def fingering_for(other)
    auto_finger_relations.where { |rel| rel.fingered_id == other.id }.first
  end

  def finger(other)
    auto_fingers << other
  end

  def finger!(other)
    finger(other)
    save
  end

  def ping(other)
    return if guest?
    fingering = fingering_for(other)
    return unless fingering.present?

    fingering.update_attributes viewed_at: Time.now
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
