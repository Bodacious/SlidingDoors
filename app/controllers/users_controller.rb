module SlidingDoors
  module Application
    class UsersController < Controller
      def mailing_address
        user = user_repository.find(params[:user_id])
        address = user.best_correspondence_address

        json(200, {
          data: {
            type: "address",
            id: "address-#{user.id}",
            attributes: {
              line_1: address.line_1,
            }
          }
        })
      end

      private

      def user_repository
        @user_repository ||= UserRepository.new
      end
    end
  end
end
