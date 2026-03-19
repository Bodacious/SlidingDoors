source "https://rubygems.org"

ruby file: "./.ruby-version"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 2.9"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 7.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "minitest", "~> 5.27"

  gem "annotate_model", "~> 1.0"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.11", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.6"
  gem "guard", "~> 2.20"
  gem "guard-minitest", "~> 3.0"
  gem "guard-rails", "~> 0.8"
  gem "pessimize", "~> 0.5", require: false
  gem "rubocop", "~> 1.85", require: false
end
