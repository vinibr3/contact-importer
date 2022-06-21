source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.7.0'

gem 'rails', '~> 7.0.3'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'sidekiq', '~> 6.5', '>= 6.5.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'rails-controller-testing'
end
