class Merchants::AddressesController < ApplicationController
  def correspondence
    merchant = Merchant.find(params[:merchant_id])
    @correspondence_address = merchant.best_correspondence_address

    if @correspondence_address.present?
      render(status: :ok)
    else
      render(status: :not_found)
    end
  end
end
