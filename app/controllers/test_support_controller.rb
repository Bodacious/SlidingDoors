module SlidingDoors
  module Application
    class TestSupportController < Controller
      def create
        user = storage.create!('users', {})
        json(201, {  id: '1', data: { "type" => "users",} })
      end


      def show
        logger.info(params.inspect)
        puts params.inspect
        storage.find(:users, params[:id])
        json(200, {
          data: {
            "type" => "users",
            id: '1',
            attributes: {
              name: "John Smith",
              email: "js@example.com",
              shipping_address_line_1: 'foobar'
            }

          }
        })
      end

      def destroy_all
        storage.clear!(:users)
        head(204,)
      end
    end
  end
end
