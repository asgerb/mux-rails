# Mux::Rails
A Rails Engine for working with [Mux](https://mux.com/).

Use `Mux::Client` to create assets and `Mux::Notifications` (built on the
`ActiveSupport::Notifications` API) to handle incoming webhook requests.

## Usage

### Setup Mux tokens

```ruby
# config/initializers/mux.rb
# QUESTION: Do we want our own wrapper around this instead of exposing a dependency's config?
MuxRuby.configure do |config|
  config.username = ENV["MUX_TOKEN_ID"]
  config.password = ENV["MUX_TOKEN_SECRET"]
end
```

### Creating assets

Create a Mux asset by using the `Mux::Client.create_asset(url)` method, passing
the url to the video. The method returns a Mux asset id.

```ruby
mux_asset_id = Mux::Client.create_asset("http://foo.com/bar.mp4")
# You probably want to store mux_asset_id somewhere for future reference
```

### Deleting assets

Delete an asset using the `Mux::Client.destroy_asset(asset_id)` method, passing
the asset id:

```ruby
Mux::Client.delete_asset("MUX_ASSET_ID")
```

### Fetching asset

Fetch an asset using the `Mux::Client.destroy_asset(asset_id)` method, passing
the asset id:

```ruby
asset = Mux::Client.get_asset("MUX_ASSET_ID")
puts asset.data.status
```

### Handling webhook requests

Using a subscriber (an object which responds to `#call`) we can then listen to
events from Mux and do further work:

```ruby
# config/initializers/mux.rb
# ...

Mux::Notifications.subscribe "video.asset.created", MuxAssetCreated.new
Mux::Notifications.subscribe "video.asset.ready", MuxAssetReady.new
Mux::Notifications.subscribe "video.asset.deleted", MuxAssetReady.new
```

```ruby
# app/subscribers/mux_asset_ready.rb

class MuxAssetReady
  def call(event)
    # event handling
    # event.object.id == mux_asset_id
    # event.data.playback_ids.first.id
  end
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'mux-rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mux-rails
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
