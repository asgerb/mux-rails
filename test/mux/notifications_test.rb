# frozen_string_literal: true

require "test_helper"

describe Mux::Notifications do
  describe "subscribing to a specific event type" do
    it "calls the subscriber with the retrieved event" do
      video_asset_ready = stub_event("video.asset.ready")
      events = []

      Mux::Notifications.subscribe("video.asset.ready") do |event|
        events << event
      end
      Mux::Notifications.instrument(video_asset_ready)

      _(events).must_include video_asset_ready
    end
  end

  describe "subscribing to a namespace of event types" do
    it "calls the subscriber with any events in the namespace" do
      video_asset_ready = stub_event("video.asset.ready")
      video_asset_created = stub_event("video.asset.created")
      events = []

      Mux::Notifications.subscribe("video.asset.") do |event|
        events << event
      end
      Mux::Notifications.instrument(video_asset_ready)
      Mux::Notifications.instrument(video_asset_created)

      _(events).must_include video_asset_ready
    end
  end

  describe Mux::Notifications::SubscriberWrapper do
    it "calls the subscriber with the last argument" do
      subscriber = Minitest::Mock.new

      subscriber.expect(:call, true, [ :last ])

      Mux::Notifications::SubscriberWrapper.call(subscriber).call(:first, :last)
    end
  end

  def stub_event(event_type)
    Mux::Event.new(
      JSON.parse(File.read(Mux::Engine.root.join("test/fixtures/#{event_type}.json")))
    )
  end
end
