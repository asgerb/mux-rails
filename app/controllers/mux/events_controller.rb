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
      event = JSON.parse(request.body.read, object_class: OpenStruct)
      Mux::Event.new(event)
    end
  end
end
