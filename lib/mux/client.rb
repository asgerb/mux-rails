require "mux_ruby"

module Mux
  class Client
    class << self
      def create_asset(url, options = {})
        playback_policy = options.fetch(:playback_policy, "public")
        request = MuxRuby::CreateAssetRequest.new
        request.input = url
        request.playback_policy = MuxRuby::PlaybackPolicy.build_from_hash(playback_policy)
        response = assets_api.create_asset(request)
        return response.data.id
      end

      private

      def assets_api
        @assets_api ||= MuxRuby::AssetsApi.new
      end
    end
  end
end
