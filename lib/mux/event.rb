# frozen_string_literal: true

module Mux
  class Event < Dry::Struct
    module Types
      include Dry.Types()
    end

    transform_keys(&:to_sym)

    attribute :id, Types::String
    attribute :type, Types::String
    attribute :created_at, Types::JSON::Time

    attribute :object do
      attribute :id, Types::Coercible::String
      attribute :type, Types::Coercible::String
    end

    attribute :environment do
      attribute :id, Types::Coercible::String
      attribute :name, Types::Coercible::String
    end

    attribute :data do
      attribute :id, Types::Coercible::String
      attribute :status, Types::Coercible::String
      attribute :created_at, Types::Coercible::Integer

      attribute? :aspect_ratio, Types::Coercible::String
      attribute? :duration, Types::Coercible::Float
      attribute? :master_access, Types::Coercible::String
      attribute? :max_stored_frame_rate, Types::Coercible::Float
      attribute? :max_stored_resolution, Types::Coercible::String
      attribute? :mp4_support, Types::Coercible::String

      attribute? :stream_key, Types::Coercible::String
      attribute? :reconnect_window, Types::Coercible::Integer
      attribute? :latency_mode, Types::Coercible::String

      attribute? :playback_ids, Types::Array do
        attribute :id, Types::Coercible::String
        attribute :policy, Types::Coercible::String
      end

      attribute? :tracks, Types::Array do
        attribute? :id, Types::Coercible::String
        attribute? :type, Types::Coercible::String

        attribute? :duration, Types::Coercible::Float

        # when type = "video"
        attribute? :max_width, Types::Coercible::Integer
        attribute? :max_height, Types::Coercible::Integer
        attribute? :max_frame_rate, Types::Coercible::Float

        # when type = "audio"
        attribute? :max_channels, Types::Coercible::Integer
        attribute? :max_channel_layout, Types::Coercible::String
      end
    end
  end
end
