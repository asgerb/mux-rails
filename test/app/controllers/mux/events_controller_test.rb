# frozen_string_literal: true

require "test_helper"

describe Mux::EventsController do

  describe "video.asset.ready event" do

    let(:event_type) { "video.asset.ready" }

    it "returns a 200 status code" do
      Mux::Notifications.subscribe(event_type) { |_| }

      post mux.events_path, params: stub_event(event_type), as: :json

      _(response.code).must_equal "200"
    end

    it "only receives one notification" do
      count = 0
      Mux::Notifications.subscribe(event_type) { |_event| count += 1 }

      post mux.events_path, params: stub_event(event_type), as: :json

      _(count).must_equal 1
    end
  end

  describe "video.asset.created event" do

    let(:event_type) { "video.asset.created" }

    it "returns a 200 status code" do
      Mux::Notifications.subscribe(event_type) { |_| }

      post mux.events_path, params: stub_event(event_type), as: :json

      _(response.code).must_equal "200"
    end

    it "only receives one notification" do
      count = 0
      Mux::Notifications.subscribe(event_type) { |_event| count += 1 }

      post mux.events_path, params: stub_event(event_type), as: :json

      _(count).must_equal 1
    end
  end

  def stub_event(identifier)
    JSON.parse(File.read(Mux::Engine.root.join("test/fixtures/#{identifier}.json")))
  end
end
