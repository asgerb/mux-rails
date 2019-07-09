ENV["RAILS_ENV"] ||= "test"
require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "minitest/rails"
require "minitest/spec"

# Consider setting MT_NO_EXPECTATIONS to not add expectations to Object.
# ENV["MT_NO_EXPECTATIONS"] = true

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

class MiniTest::Spec
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers
  include ActiveSupport::Testing::Assertions
  include ActionDispatch::Assertions::ResponseAssertions
end

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new
