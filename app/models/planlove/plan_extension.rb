class Planlove
  module PlanExtension
    extend ActiveSupport::Concern

    included do
      has_many :planloves, :dependent => :destroy
      has_many :loved_accounts, :through => :planloves, :class_name => :Account
    end

    module ClassMethods
      def planlove_filter!(doc)
        planloves = Hash.new(0)

        doc.gsub!(/(^|\W)@(\w+)/) do
          account_name = $2
          if $1 == "\\" or (account = Account[account_name]).blank?
            $&
          else
            planloves[account.id] += 1

            %<#{$1}<a href="/#{account_name}" class="planlove">@#{account_name}</a>>
          end
        end

        # escape @ signs with \@
        doc.gsub!(/\\@/,'@')

        planloves
      end
    end

    def planlove!(doc)
      planloves = self.class.planlove_filter!(doc)

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
