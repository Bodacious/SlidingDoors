module DeliverabilityChecks
  class AustraliaDeliverabilityCheck < DeliverabilityCheck
    def deliverable?
      @line_1.present? && @postcode.present? && @county.present?
    end
  end
end
