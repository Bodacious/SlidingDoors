module SlidingDoors
  module Application
    class ErrorsController < Controller

      def not_found
        json(404, { error: 'not_found' })
      end

      def bad_request(error)
        json(400, { 'error' => error })
      end

      def internal_error(error)
        json(500, { 'error' => error })
      end
    end
  end
end
