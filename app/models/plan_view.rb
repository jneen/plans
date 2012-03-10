class PlanView < ActiveRecord::Base
  belongs_to :account
  belongs_to :viewed, :class_name => :Account
end
