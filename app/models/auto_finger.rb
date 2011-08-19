class AutoFinger < ActiveRecord::Base
  belongs_to :account
  belongs_to :fingered, :class_name => :Account
end
