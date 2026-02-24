module SlidingDoors
  module Persistence

    class MemoryStore
      def initialize
        @mutex = Mutex.new
        @next_id = 1
        @databases = Hash.new { |h, k| h[k] = {} }
      end

      def create!(resource_name, attrs)
        @mutex.synchronize do
          id = @next_id
          @next_id += 1
          @databases[resource_name.to_sym][id] = attrs.merge("id" => id)
          @databases[resource_name.to_sym][id]
        end
      end

      def find(resource_name, id)
        @mutex.synchronize { @databases[resource_name.to_sym][id] }
      end

      def clear!(resource_name)
        @mutex.synchronize do
          @databases[resource_name.to_sym].clear
          @next_id = 1
        end
      end
    end
  end
end
