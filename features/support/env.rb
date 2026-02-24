# features/support/env.rb

require "rack/test"

# features/support/env.rb
require_relative "../step_definitions/http_client"

BASE_URL = ENV.fetch("APP_BASE_URL", "http://127.0.0.1:9292")

Before do
  @http = HttpClient.new(base_url: BASE_URL)
end


World(Rack::Test::Methods)

def app
  Rails.application
end
