class Planlove < ActiveRecord::Base
  belongs_to :account
  belongs_to :plan
end
