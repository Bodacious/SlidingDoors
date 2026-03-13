# == Schema Information
#
# id         :integer         not null
# first_name :string          not null
# last_name  :string          not null
# email      :string          not null
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class User < ApplicationRecord
  has_one :shipping_address,
          -> { where(address_type: "shipping") },
          class_name: "Address", as: :addressable

  has_one :billing_address,
          -> { where(address_type: "billing") },
          class_name: "Address", as: :addressable

  ##
  # The best address to use for correspondence.
  #
  # @return [Address, nil]
  def best_correspondence_address
    [
      shipping_address,
      billing_address
    ].compact.find(&:deliverable?)
  end
end
