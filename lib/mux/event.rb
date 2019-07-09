module Mux
  class Event
    # QUESTION: Is there security concerns here? This implementation seems very naive ;-)
    def initialize(payload)
      @event = OpenStruct.new(payload)
    end

    def method_missing(method, *args, &block)
      @event.send(method, *args, &block)
    end
  end
end
