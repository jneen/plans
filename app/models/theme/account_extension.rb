module Theme
  module AccountExtension
    extend ActiveSupport::Concern

    def theme
      Theme.wrap(theme_name)
    end

    def theme=(other)
      self.theme_name = Theme.wrap(other).name
    end
  end
end
