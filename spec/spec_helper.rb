# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../spec', __FILE__))

require 'etcdig'

module Etcd
  module SpecHelper
    # add helpers here
  end
end

RSpec.configure do |rspec|
  rspec.include Etcd::SpecHelper
  rspec.color = true
end
