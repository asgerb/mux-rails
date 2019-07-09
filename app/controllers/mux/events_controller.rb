module Mux
  class EventsController < ActionController::Base
    # QUESTION: Do we need protect_from_forgery?

    def create
      Mux::Notifications.instrument(event)
      head :ok
    end

    private

    def event
      payload = JSON.parse(request.body.read, symbolize_names: true)
      Mux::Event.new(payload)
    end
  end
end
