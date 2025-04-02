# Next

# 1.1.0

- Added `live_stream_id` field to `Event` (@brainimus)
- Added field to example test payload (`video.asset.ready.json`) (@brainimus)
- Upgraded to mux-ruby ~> 5 (@tomasc)
- Upgraded to Ruby 3.3.5 (@tomasc)
- Upgraded to rubocop-rails-omakase (@tomasc)
- Upgraded to Rails >= 7 (@tomasc)

# 1.0.2

- Made tracks attributes optional (@tomasc)

# 1.0.1

- Added support for live streams (@tomasc)

# 1.0.0

- Upgraded to `mux_ruby ~> 3.0`

# 0.2.1

- Refactored `Mux::Event` class to `Dry::Struct`
- Added Rubocop and cleaned up all files

# 0.2.0

- Added compatibilty with Rails 6
- Added GitHub Actions
- Upgraded Mux to 1.8
- Refactored subscriptions to blocks
