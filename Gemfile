source 'https://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


if defined?(JRUBY_VERSION)
  gem 'jdbc-mysql'
  gem 'activerecord-jdbc-adapter'
  gem 'activerecord-jdbcmysql-adapter'
  gem 'jruby-pageant'
  gem 'jruby-openssl'
  gem 'warbler'
else
  gem 'mysql2'
  # To use debugger
  gem 'ruby-debug-base19'
  gem 'ruby-debug19'
  gem 'ruby-debug-ide19'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use devise
gem 'devise'

# To use cancan
gem 'cancan'

gem 'roo'
gem 'rufus-scheduler'
gem 'psych', :platforms => :ruby
