source 'http://rubygems.org'

gem 'rails',          '3.1.0'
gem 'sass-rails',     '3.1.2'
gem 'coffee-script',  '2.2.0'
gem 'uglifier',       '1.0.0'
gem 'devise',         '1.4.7'
gem 'slim',           '0.9.4'
gem 'jquery-rails',   '1.0.12'
gem 'bson_ext',       '1.3.1'
gem 'mongoid',        '2.2.1'
gem 'feedzirra',      '0.0.24'
gem 'girl_friday',    '0.9.5'

group :development do
  gem 'wirble', '0.1.3'
end

group :test do
  gem 'capybara',       '1.0.1'
  gem 'mongoid-rspec',  '1.4.4'
  gem 'fabrication',    '1.0.0'
end

group :development, :test do
  gem 'database_cleaner', '0.6.7'
  gem 'rspec-rails',      '2.6.1'
end
if RUBY_ENGINE.eql? 'jruby' or RUBY_VERSION < '1.9'
  gem 'ruby-debug'
  gem 'therubyrhino', '1.72.8', group: :production
  gem 'jruby-openssl' if RUBY_ENGINE.eql? 'jruby'
else
  gem 'unicorn', '4.1.1'
  # Modify the conditional when ruby-debug19 supports Ruby >= 1.9.3
  gem 'ruby-debug19', '0.11.6', require: 'ruby-debug' if RUBY_VERSION < '1.9.3'
  gem 'therubyracer', '0.9.3beta1', group: :production
end
