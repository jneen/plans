class TextFilter < Redcarpet::Render::HTML
  def postprocess(doc)
    # clean up the doc to prevent xss stuff
    Sanitize.clean(doc, sanitize_config)
  end

private
  def sanitize_config
    @sanitize_config ||= begin
      config = Sanitize::Config::RELAXED.dup
      config[:elements] = config[:elements].dup

      config[:elements] << 'hr'

      config
    end
  end
end
