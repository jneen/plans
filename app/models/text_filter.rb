class TextFilter < Redcarpet::Render::HTML
  def postprocess(doc)
    # clean up the doc to prevent xss stuff
    Sanitize.clean(doc, sanitize_config)
  end

private
  def sanitize_config
    @sanitize_config ||= Sanitize::Config::RELAXED.dup.tap do |config|
      config[:elements] = config[:elements].dup

      config[:elements] << 'hr'
    end
  end
end
