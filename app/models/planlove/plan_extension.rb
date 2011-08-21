class Planlove
  module PlanExtension
    extend ActiveSupport::Concern

    included do
      has_many :planloves
      has_many :loved_accounts, :through => :planloves, :class_name => :Account
    end

    def planlove!(doc)
      planloves = Hash.new(0)

      doc.gsub!(/(^|\s)@(\w+)/) do
        account_name = $2
        account = Account.find_by_login(account_name)
        if account.present?
          planloves[account.id] += 1

          %[#{$1}<a href="/#{account_name}" class="planlove">@#{account_name}</a>]
        else
          $&
        end
      end

      # escape @ signs with \@
      doc.gsub!(/\\@/,'@')

      self.planloves = planloves.map do |account_id, count|
        Planlove.new(
          account_id: account_id,
          count: count
        )
      end

      doc
    end
  end
end
