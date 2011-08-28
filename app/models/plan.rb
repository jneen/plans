class Plan < ActiveRecord::Base
  include Planlove::PlanExtension

  belongs_to :account
  validates_presence_of :account

  def html
    self[:html].html_safe
  end

private
  before_validation :render_markdown
  def render_markdown
    rendered = markdown.render(self.contents)
    planlove!(rendered)
    self.html = rendered
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(TextFilter.new(:hard_wrap => true))
  end
end
