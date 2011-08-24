module PlansHelper
  def plan_link(account, extra='', &blk)
    extra = capture(&blk) if block_given?

    text = "@#{account.login}"
    text << " #{extra}" if extra.present?

    link_to text, plan_path(account.login)
  end
end
