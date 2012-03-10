source 'http://rubygems.org'

gem 'rails', '~> 3.1'

# models
gem 'pg'
gem 'squeel'

# views
gem 'haml'

# markdown syntax
gem 'redcarpet', :git => 'git://github.com/tanoku/redcarpet',
                 :ref => '6b43f042305eb63620e3771a977f45e24ea7b576' # 2.0.0.b3

# safe html
gem 'sanitize'

group :development, :test do
  gem 'heroku', '~> 2.4'
  gem 'rspec', '~> 2'
  gem 'rspec-rails'
  gem 'autotest'
  gem 'autotest-inotify', :require => 'autotest/inotify'
  gem 'ffaker'
end

group :development do
  gem 'unicorn'
end
