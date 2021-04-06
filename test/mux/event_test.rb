# frozen_string_literal: true

require "test_helper"

describe Mux::Event do
  it "wraps with Dry Initializer" do
    event_type = "video.asset.ready"
    event = Mux::Event.new(stub_event(event_type))

    _(event.id).must_equal "3a56ac3d-33da-4366-855b-f592d898409d"
    _(event.type).must_equal event_type
    _(event.created_at).must_equal Time.parse("2018-02-15T01:04:45.000Z")

    _(event.object).must_respond_to :id
    _(event.object).must_respond_to :type

    _(event.environment).must_respond_to :id
    _(event.environment).must_respond_to :name

    _(event.data).must_respond_to :aspect_ratio
    _(event.data).must_respond_to :created_at
    _(event.data).must_respond_to :duration
    _(event.data).must_respond_to :id
    _(event.data).must_respond_to :master_access
    _(event.data).must_respond_to :max_stored_frame_rate
    _(event.data).must_respond_to :max_stored_resolution
    _(event.data).must_respond_to :mp4_support
    _(event.data).must_respond_to :status

    _(event.data.playback_ids.sample).must_respond_to :id
    _(event.data.playback_ids.sample).must_respond_to :policy

    _(event.data.tracks.sample).must_respond_to :id
    _(event.data.tracks.sample).must_respond_to :type
    _(event.data.tracks.sample).must_respond_to :duration
  end

  def stub_event(event_type)
    JSON.parse(
      File.read(Mux::Engine.root.join("test/fixtures/#{event_type}.json"))
    )
  end
end
