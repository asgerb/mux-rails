require "test_helper"

describe Mux::Notifications do
  describe "subscribing to a specific event type" do
    it "calls the subscriber with the retrieved event" do
      video_asset_ready = stub_event("video.asset.ready")
      events = []
      subscriber = ->(evt){ events << evt }

      Mux::Notifications.subscribe("video.asset.ready", subscriber)
      Mux::Notifications.instrument(video_asset_ready)

      events.must_include video_asset_ready
    end
  end

  describe "subscribing to a namespace of event types" do
    it "calls the subscriber with any events in the namespace" do
      video_asset_ready = stub_event("video.asset.ready")
      events = []
      subscriber = ->(evt){ events << evt }

      Mux::Notifications.subscribe("video.asset.", subscriber)
      Mux::Notifications.instrument(video_asset_ready)

      events.must_include video_asset_ready
    end
  end

  describe Mux::Notifications::SubscriberWrapper do
    it "calls the subscriber with the last argument" do
      subscriber = MiniTest::Mock.new

      subscriber.expect(:call, true, [:last])

      Mux::Notifications::SubscriberWrapper.call(subscriber).call(:first, :last)
    end
  end

  def stub_event(identifier)
    payload = JSON.parse(File.read(Mux::Engine.root.join("test/fixtures/#{identifier}.json")))
    Mux::Event.new(payload)
  end
end
