module Theme
  def self.create(name)
    name ||= 'default'

    klass = (name !~ /\W/) ? LocalTheme : ExternalTheme

    klass.new(name)
  end

  DIR = Rails.root.join('public/stylesheets/themes')

  class Base
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def external?
      !local?
    end

    def valid?
      true
    end

    def url
      raise "plz define url"
    end

    def pretty_name
      raise "plz define pretty_name"
    end
  end

  class LocalTheme < Base
    def local?
      true
    end

    def pretty_name
      name.split('_').map(&:capitalize).join(' ')
    end

    def valid?
      DIR.join("#{name}.css").readable?
    end

    def url
      local_name = valid? ? name : 'default'
      "/stylesheets/themes/#{local_name}.css"
    end
  end

  class ExternalTheme < Base
    def local?
      false
    end

    def url
      name
    end

    def pretty_name
      "Custom Stylesheet <#{name}>"
    end
  end
end
