class TextFilter < Redcarpet::Render::HTML
  # planlove
  def postprocess(doc)
    doc.gsub!(/(^|\s)@(\w+)/) do
      account_name = $2
      account = Account.find_by_login(account_name)
      if account.present?
        %[#{$1}<a href="/#{account_name}" class="planlove">@#{account_name}</a>]
      else
        $&
      end
    end

    doc
  end
end
