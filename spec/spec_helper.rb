$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../spec', __FILE__))

require 'etcdist'

module Etcd
  module SpecHelper
    # add helpers here
  end
end

RSpec.configure do |config|
  config.include Etcd::SpecHelper
  config.color = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
