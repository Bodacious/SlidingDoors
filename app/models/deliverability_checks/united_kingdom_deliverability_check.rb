module DeliverabilityChecks
  class UnitedKingdomDeliverabilityCheck < DeliverabilityCheck
    def deliverable?
      @line_1.present? && @postcode.present?
    end
  end
end
