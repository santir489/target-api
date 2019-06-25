source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.1', '>= 1.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.3'
gem 'devise', '~> 4.2'
gem 'devise_token_auth', '~> 1.1'  
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'geokit-rails', '~> 2.3', '>= 2.3.1'
gem 'jbuilder', '~> 2.9', '>= 2.9.1'
gem 'one_signal', '~> 1.2'
gem 'pry', '~> 0.12.2'
gem 'rack-cors'  

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8' 
end

group  :test do
  gem 'factory_bot_rails', '4.8.2'
  gem 'faker', '~> 1.6', '>= 1.6.3'
  gem 'shoulda-matchers', '~> 3.1.1'
end

group :development do
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'  
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
