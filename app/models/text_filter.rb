class TextFilter < Redcarpet::Render::HTML
  def preprocess(doc)
    # clean up the doc to prevent xss stuff
    Sanitize.clean(doc, Sanitize::Config::RELAXED)
  end
end
