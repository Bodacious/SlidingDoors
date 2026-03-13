module DeliverabilityChecks
  class DeliverabilityCheck
    def initialize(line_1:, line_2:, postcode:, town:, county:, country:)
      @line_1 = line_1
      @line_2 = line_2
      @postcode = postcode
      @town = town
      @county = county
      @country = country
    end

    def deliverable?
      true
    end
  end
end
