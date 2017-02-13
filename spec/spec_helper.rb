$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pry-byebug"
require "e_way_client"
require "pathname"
require "active_support/core_ext/hash/indifferent_access"
require "yaml"
require "virtus-matchers"
require "timecop"

SPEC_DIR = Pathname.new(File.dirname(__FILE__))
CONFIG_YML = SPEC_DIR.join("config.yml")
CONFIG = YAML.load_file(CONFIG_YML).with_indifferent_access.merge(
  log: false,
  logger: Logger.new(STDOUT)
)

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  %i[username password secret].each do |var|
    c.filter_sensitive_data("[#{var}]") { CONFIG[var] }
  end
end
