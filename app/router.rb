module SlidingDoors
  module Application


    class Router
      def call(env)
        require_relative "controllers/errors_controller"
        require_relative "controllers/health_controller"
        require_relative "controllers/test_support_controller"
        require_relative "controllers/users_controller"

        req = Rack::Request.new(env)
        case [req.request_method, req.path_info]
        in ['GET', '/health']
          Application::HealthController.new(req).health

        in ['GET', %r{/users/(?<user_id>[^\/]+)/mailing_address}]
          req.params['user_id'] = $1.to_i
          Application::UsersController.new(req).mailing_address

        in ['POST', '/test_support/resources/users/reset']
          Application::TestSupportController.new(req).destroy_all

        in ['POST', '/test_support/resources/users']
          Application::TestSupportController.new(req).create

        in ['GET', %r{/test_support/(.+)}]
          Application::TestSupportController.new(req).show


        else
          Application::ErrorsController.new(req).not_found

        end
      rescue KeyError, ArgumentError, JSON::ParserError => e
        Application::ErrorsController.new(req).bad_request(e.message)

      rescue StandardError => e
        Application::ErrorsController.new(req).internal_error(e.message)

      end

    end
  end
end
