class Plan < ActiveRecord::Base
  belongs_to :account

  def to_html
    return '' if contents.nil?

    (@to_html ||= markdown.render(contents)).dup.html_safe
  end

private
  def markdown
    @markdown ||= Redcarpet::Markdown.new(TextFilter.new)
  end
end
