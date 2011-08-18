module ApplicationHelper
  def title_components
    @title_components ||= controller.send(:title_components)
  end

  def title_tag
    content_tag :title, title_components.reverse.join(' | ')
  end

  def canonical_path
    @canonical_path ||= controller.send(:canonical_path)
  end

  # [Jay] You'd think there'd be a simpler safe way to do it. o wel.
  def canonical_url
    uri = URI.parse(canonical_path)
    canonical = URI.parse(uri.path)
    canonical.query = uri.query
    canonical.scheme = request.protocol.chomp('://')
    canonical.host = request.host
    canonical.port = request.port

    uri
  end

  def canonical_link_tag
    # [Jay] the `tag` helper was stupidly html-encoding the canonical url,
    # which resulted in query strings like ?a=1&amp;b=2, which is teh sux.
    tag :link, :rel => 'canonical', :href => canonical_url
    # "<link rel='canonical' href='#{canonical_url}' />"
  end
end
