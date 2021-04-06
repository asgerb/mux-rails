# frozen_string_literal: true

require "active_support/notifications"

module Mux
  module Notifications
    class << self
      def instrument(event)
        return unless event
        ActiveSupport::Notifications.instrument "mux.#{event.type}", event
      end

      def subscribe(name, &block)
        ActiveSupport::Notifications.subscribe %r{^mux\.#{name}}, SubscriberWrapper.call(block)
      end
    end

    class SubscriberWrapper < Struct.new(:subscriber)
      def self.call(subscriber)
        new(subscriber)
      end

      def call(*args)
        payload = args.last
        subscriber.call(payload)
      end
    end
  end
end
