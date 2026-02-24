module SlidingDoors
  module Application
    class HealthController < Controller
      def health
        json(200, {
          data: {
            type: "health-check",
            id: SecureRandom.uuid,
            attributes: { ok: true }.merge(params)
          }
        })
      end
    end
  end
end
