class Users::AddressesController < ApplicationController
  def correspondence
    user = User.find(params[:user_id])
    @correspondence_address = user.best_correspondence_address

    if @correspondence_address.present?
      render(status: :ok)
    else
      render(status: :not_found)
    end
  end
end
