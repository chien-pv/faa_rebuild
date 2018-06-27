source "https://rubygems.org"
source "https://rails-assets.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootstrap-sass"
gem "coffee-rails", "~> 4.2"
gem "ffaker"
gem "font-awesome-rails"
gem "jquery-turbolinks"
gem "jquery-rails"
gem "jbuilder", "~> 2.5"
gem "pg", "~> 0.20.0"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.3"
gem "react_on_rails", "8.0.6"
gem "responders"
gem "sass-rails", "~> 5.0"
gem "versionist"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "config"
gem "kaminari"
gem "simple_form"
gem "foreman"
gem "redcarpet"
gem "faker" , git: "https://github.com/stympy/faker"
gem "devise"
gem "figaro"
gem "delayed_job_active_record"
gem "rails_select_on_includes"
gem "active_model_serializers"
gem "ransack"
gem "friendly_id"
gem "paranoia"
gem "sitemap_generator"
gem "simple_token_authentication", "~> 1.0"
gem "activerecord-import"
gem "redis", "~> 3.0"
gem "social-share-button"
gem "truncate_html"

group :test do
  gem "shoulda-matchers", "~> 3.0"
  gem "database_cleaner", "~> 1.5"
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "pry"
  gem "sshkit-sudo"
  gem "capistrano", "3.9.0"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano-rvm"
  gem "capistrano3-puma"
  gem "capistrano3-nginx"
  gem "capistrano-upload-config"
  gem "rspec-rails", "~> 3.7"
  gem "factory_bot_rails"
  gem "capybara", "~> 2.5"
  gem "rails-controller-testing"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "mini_racer", platforms: :ruby
gem "webpacker_lite"
