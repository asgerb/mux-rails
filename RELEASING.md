# Releasing

1. Create a branch for the release: `git checkout -b release-vx.x.x`
1. Bump gem version in `lib/mux/rails/version.rb`. Try to adhere to SemVer.
1. Add version heading/entries to `CHANGELOG.md`.
1. Make sure your local dependencies are up to date: `bundle`
1. Ensure that tests are green: `bundle exec rake`
1. Make a PR to asgerb/mux-rails.
1. Build and release gem: `bundle exec rake release`
1. Merge asgerb/mux-rails PR
