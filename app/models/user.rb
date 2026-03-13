# == Schema Information
#
# id         :integer         not null
# first_name :string          not null
# last_name  :string          not null
# email      :string          not null
# shipping_address_line_1 :string
# shipping_address_line_2 :string
# shipping_address_postcode :string
# shipping_address_county :string
# shipping_address_country :string
# shipping_address_town :string
# billing_address_line_1 :string
# billing_address_line_2 :string
# billing_address_postcode :string
# billing_address_county :string
# billing_address_country :string
# billing_address_town :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class User < ApplicationRecord
  ##
  # The best address to use for correspondence.
  #
  # @return [Address, nil]
  def best_correspondence_address
    [
      shipping_address,
      billing_address
    ].find(&:deliverable?)
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
