# frozen_string_literal: true

module Mux
  class Event < Dry::Struct
    module Types
      include Dry.Types()
    end

    transform_keys(&:to_sym)

    attribute :type, Types::String
    attribute :id, Types::String
    attribute :created_at, Types::JSON::Time

    attribute :object do
      attribute :type, Types::String
      attribute :id, Types::String
    end

    attribute :environment do
      attribute :name, Types::String
      attribute :id, Types::String
    end

    attribute :data do
      attribute :id, Types::String
      attribute :status, Types::String
      attribute :created_at, Types::JSON::Time

      attribute? :aspect_ratio, Types::String
      attribute? :duration, Types::Float
      attribute? :master_access, Types::String
      attribute? :max_stored_frame_rate, Types::Float
      attribute? :max_stored_resolution, Types::String
      attribute? :mp4_support, Types::String

      attribute? :playback_ids, Types::Array do
        attribute :id, Types::String
        attribute :policy, Types::String
      end

      attribute? :tracks, Types::Array do
        attribute :id, Types::String
        attribute :type, Types::String

        attribute :duration, Types::Float

        # when type = "video"
        attribute? :max_width, Types::Integer
        attribute? :max_height, Types::Integer
        attribute? :max_frame_rate, Types::Float

        # when type = "audio"
        attribute? :max_channels, Types::Integer
        attribute? :max_channel_layout, Types::String
      end
    end
  end
end
