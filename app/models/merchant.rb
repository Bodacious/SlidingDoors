class Merchant < ApplicationRecord
  ##
  # The best address to use for correspondence.
  #
  # @return [Address, nil]
  def best_correspondence_address
    [
      registered_address,
      shipping_address,
      billing_address
    ].find(&:deliverable?)
  end

  def registered_address
    @registered_address ||=
      Address.new(
      line_1: registered_address_line_1,
      line_2: registered_address_line_2,
      postcode: registered_address_postcode,
      town: registered_address_town,
      county: registered_address_county,
      country: registered_address_country,
    )
  end

  def shipping_address
    @shipping_address ||=
      Address.new(
      line_1: shipping_address_line_1,
      line_2: shipping_address_line_2,
      postcode: shipping_address_postcode,
      town: shipping_address_town,
      county: shipping_address_county,
      country: shipping_address_country,
    )
  end

  def billing_address
    @billing_address ||=
    Address.new(
      line_1: billing_address_line_1,
      line_2: billing_address_line_2,
      postcode: billing_address_postcode,
      town: billing_address_town,
      county: billing_address_county,
      country: billing_address_country,
      )
  end
end
