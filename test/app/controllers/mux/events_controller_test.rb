require "test_helper"

describe Mux::EventsController do
  it "works" do
    count = 0
    Mux::Notifications.subscribe("video.asset.ready") { |_event| count += 1 }

    post mux.events_path, params: stub_event("video.asset.ready"), as: :json

    response.code.must_equal "200"
    count.must_equal 1
  end

  def stub_event(identifier)
    JSON.parse(File.read(Mux::Engine.root.join("test/fixtures/#{identifier}.json")))
  end
end
