# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "minitest/spec"
require "factories"

Turn.config.natural = true

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class Minitest::Spec
  include ActiveSupport::Testing::Assertions # assert_difference etc...
  include ActiveSupport::Testing::SetupAndTeardown # before, after

  # Support rspec-style context-blocks
  class << self
    alias_method :context, :describe
  end

end

# A bit more dry validation tests
#     m = Message.create(text: '')
#     m.must_have_invalid :text
module Minitest::Assertions
  def assert_has_invalid(field, model)
    model.must_be :invalid?
    model.errors[field].must_be :present?
  end
end
ActiveRecord::Base.infect_an_assertion :assert_has_invalid, :must_have_invalid
