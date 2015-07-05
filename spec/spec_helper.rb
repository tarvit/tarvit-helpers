require 'bundler/setup'
Bundler.setup

# gems
require 'pry'

# files
require_relative '../lib/tarvit-helpers'
require_relative '../lib/tarvit-helpers/modules/non_shared_accessors'
require_relative '../lib/tarvit-helpers/modules/simple_crypt'
require_relative '../lib/tarvit-helpers/modules/conditional_logger'
require_relative '../lib/tarvit-helpers/extensions/counter'

include TarvitHelpers

RSpec.configure do |config|

end
