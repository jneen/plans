class Plan < ActiveRecord::Base
  include Planlove::PlanExtension

  belongs_to :account
  validates_presence_of :contents
  validates_presence_of :html
  validates_presence_of :account_id

  def html
    self[:html].html_safe
  end

  def to_html
    return '' if contents.nil?

    (@to_html ||= markdown.render(contents)).dup.html_safe
  end

private
  before_validation :render_markdown
  def render_markdown
    rendered = markdown.render(self.contents)
    planlove!(rendered)
    self.html = rendered
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(TextFilter.new)
  end
end
