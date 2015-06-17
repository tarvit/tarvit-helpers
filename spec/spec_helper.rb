require 'bundler/setup'
Bundler.setup

# gems
require 'pry'

# files
require_relative '../lib/tarvit-helpers'
require_relative '../lib/modules/non_shared_accessors'
require_relative '../lib/modules/simple_crypt'
include TarvitHelpers

RSpec.configure do |config|

end
