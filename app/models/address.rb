# frozen_string_literal: true

# == Schema Information
#
# id              :integer         not null
# line_1          :string
# line_2          :string
# postcode        :string
# town            :string
# county          :string
# country         :string
# address_type    :string
# addressable_id  :integer         not null
# addressable_type:string          not null
# created_at      :datetime        not null
# updated_at      :datetime        not null
# ==
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  ##
  # A basic check to make sure that an address is actually deliverable
  # based on the presence of the required fields.
  #
  def deliverable?
    deliverability_check.deliverable?
  end

  def to_s
    [ line_1, line_2, postcode, town, county, country ].select(&:present?).join("\n")
  end

  private

  def deliverability_check
    @deliverability_check ||=
      DeliverabilityChecks::Registry.find_for_country(country).new(
        line_1: line_1,
        line_2: line_2,
        postcode: postcode,
        town: town,
        county: county,
        country: country
      )
  end
end
