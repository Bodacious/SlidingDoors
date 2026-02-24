class Users::AddressesController < ApplicationController
  def correspondence
    user = User.find(params[:user_id])
    @correspondence_address = user.best_correspondence_address
  end
end
