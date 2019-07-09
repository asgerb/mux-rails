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

To create a Mux asset use the `Mux::Client.create_action(url)` method, passing
in the url to the video. The method returns a Mux asset id.

```ruby
mux_asset_id = Mux::Client.create_asset("http://foo.com/bar.mp4")

# store the mux_asset_id somewhere for future reference
```

### Handling webhook requests

Using a subscriber (an object which responds to `#call`) we can then listen to
events from Mux and do further work:

```ruby
# config/initializers/mux.rb
# ...

Mux::Notifications.subscribe "video.asset.ready", MuxAssetReady.new
```

```ruby
# app/subscribers/mux_asset_ready.rb

class MuxAssetReady
  def call(event)
    # event handling
    # event.id == mux_asset_id
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
