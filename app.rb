module SlidingDoors
  require 'securerandom'
  require "persistence"
  require_relative "app/router"

  module Application
    def self.storage=(value)
      @storage = value
    end
    def self.storage
      @storage
    end
    self.storage = Persistence::MemoryStore.new

    class Controller
      def initialize(req)
        @req = req
      end

      protected

      def storage
        Application.storage
      end

      def logger
        require 'logger'
        @logger ||= Logger.new(STDOUT)
      end

      private

      def params
        @req.params
      end

      def json(status, obj)
        [status, { 'content-type' => 'application/json' }, [JSON.dump(obj)]]
      end

      def head(status)
        [status, {}, [""]]
      end
    end
  end
end
