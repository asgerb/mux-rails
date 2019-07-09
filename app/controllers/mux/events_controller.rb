module Mux
  class EventsController < ActionController::Base
    # QUESTION: Is this the right way to handle it?
    if ::Rails.application.config.action_controller.default_protect_from_forgery
      skip_before_action :verify_authenticity_token
    end

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
