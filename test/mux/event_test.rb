require "test_helper"

describe Mux::Event do
  it "wraps an OpenStruct" do
    event_type = "video.asset.ready"
    event = Mux::Event.new(stub_event(event_type))

    _(event.type).must_equal event_type
    _(event.object).must_respond_to :id
  end

  def stub_event(event_type)
    JSON.parse(
      File.read(Mux::Engine.root.join("test/fixtures/#{event_type}.json")),
      object_class: OpenStruct
    )
  end
end
