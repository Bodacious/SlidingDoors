# frozen_string_literal: true

##
# Represents a physical address that we can deliver to.
#
class Address
  def initialize(line_1:, line_2:, postcode:, town:, county:, country:)
    @line_1 = line_1
    @line_2 = line_2
    @postcode = postcode
    @town = town
    @county = county
    @country = country
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

  ##
  # A basic check to make sure that an address is actually deliverable
  # based on the presence of the required fields.
  #
  def deliverable?
    @deliverability_check.deliverable?
  end

  def to_s
    [@line_1, @line_2, @postcode, @town, @county, @country].select(&:present?).join("\n")
  end
end
