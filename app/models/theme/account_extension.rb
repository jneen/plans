module Theme
  module AccountExtension
    extend ActiveSupport::Concern

    def theme
      Theme.create(theme_name)
    end
  end
end
