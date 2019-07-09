require "active_support/notifications"

module Mux
  module Notifications
    class << self
      def instrument(event)
        return unless event
        ActiveSupport::Notifications.instrument "mux.#{event.type}", event
      end

      def subscribe(name, callable = Proc.new)
        ActiveSupport::Notifications.subscribe %r{^mux\.#{name}}, SubscriberWrapper.call(callable)
      end
    end

    class SubscriberWrapper < Struct.new(:subscriber)
      def self.call(callable)
        new(callable)
      end

      def call(*args)
        payload = args.last
        subscriber.call(payload)
      end
    end
  end
end
