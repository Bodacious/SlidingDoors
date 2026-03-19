# frozen_string_literal: true

module DeliverabilityChecks
  ##
  # Store of registered deliverability checks.
  # Maps a country name to a deliverability check class name.
  # Keeps Address model closed for modification while open for extension.
  #
  module Registry
    class << self
      ##
      # @param country [String]
      # @return [DeliverabilityCheck]
      def find_for_country(country)
        (registry[country] || 'DeliverabilityChecks::DeliverabilityCheck').constantize
      end

      ##
      # The store of registered deliverability checks.
      #
      # @return [Hash]
      def registry = @registry ||= {}

      ##
      # Register a deliverability check for a country.
      #
      # @param country [String]
      # @param deliverability_check_class_name [String]
      def register(country, deliverability_check_class_name)
        registry[country.to_s] = deliverability_check_class_name.to_s
      end
    end

    register 'United Kingdom', 'DeliverabilityChecks::UnitedKingdomDeliverabilityCheck'
    register 'Australia', 'DeliverabilityChecks::AustraliaDeliverabilityCheck'
  end
end
