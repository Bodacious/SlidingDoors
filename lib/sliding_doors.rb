
require 'json'
require_relative '../app'

module SlidingDoors
  def self.application
    app = Application::Router.new
    Rack::Builder.new do
      # use Middleware::RequestId
      run app
    end
  end
end
