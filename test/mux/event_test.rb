require "test_helper"

describe Mux::Event do
  it "wraps a payload hash" do
    event_type = "video.asset.ready"
    event = Mux::Event.new(stub_event(event_type))

    event.type.must_equal event_type
  end

  def stub_event(identifier)
    JSON.parse(File.read(Mux::Engine.root.join("test/fixtures/#{identifier}.json")))
  end
end
