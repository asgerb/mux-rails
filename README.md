# Mux::Rails

![Gem Version](https://badge.fury.io/rb/mux-rails.svg)
![Ruby](https://github.com/asgerb/mux-rails/workflows/Ruby/badge.svg)

A Rails Engine for working with [Mux](https://mux.com/).

Use `Mux::Client` to create assets and `Mux::Notifications` (built on the
`ActiveSupport::Notifications` API) to handle incoming webhook requests.

## Installation

Run

```bash
bundle add mux-rails
`

or add this line to your application's Gemfile:

```ruby
gem 'mux-rails'
```

```ruby
# config/routes.rb
mount Mux::Engine, at: "/mux" # provide a custom path
```

Make sure to configure the webhooks at mux.com to point to `https://yourwebsite.com/mux/events`.

## Usage

### Setup Mux tokens

```ruby
# config/initializers/mux.rb
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
Mux::Client.destroy_asset("mux_asset_id")
```

### Fetching asset

Fetch an asset using the `Mux::Client.get_asset(asset_id)` method, passing
the asset id. This returns a
[JSON object](https://docs.mux.com/docs/webhooks#section-example-response):

```ruby
asset = Mux::Client.get_asset("mux_asset_id")
puts asset.data.status
```

### Handling webhook requests

Using a subscriber with a block we can listen to incoming events from Mux and do further work:

```ruby
# config/initializers/mux.rb
# ...

Mux::Notifications.subscribe "video.asset.created" do |event|
  # handle asset created
  # event.id == mux_asset_id
end

Mux::Notifications.subscribe "video.asset.ready" do |event|
  # handle asset ready
  # event.id == mux_asset_id
end

Mux::Notifications.subscribe "video.asset.deleted" do |event|
  # handle asset deleted
  # event.id == mux_asset_id
end
```

The block is passed an event which is simply the incoming JSON (take a peek
in [fixtures](test/fixtures) for examples) wrapped in [`Mux::Event`](lib/mux/event.rb) class based on
`Dry::Struct`.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
