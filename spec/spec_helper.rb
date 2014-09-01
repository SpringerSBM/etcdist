$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../spec', __FILE__))

require 'etcdist'
require 'etcdist/log'

Etcdist::Log.level = :warn

module Etcdist
  module SpecHelper
    def nothing
      {}
    end

    def pretend_etcd_contains(data = nothing)
      allow(etcd).to receive(:exists?).with(any_args).and_return(!data.empty?)
      data.each do |dir, entries|
        nodes = entries.map { |k, v| { 'key' => k, 'value' => v } }
        opts = { 'node' => { 'dir' => true, 'nodes' => nodes } }
        allow(etcd).to receive(:get).with(dir).and_return(Etcd::Response.new(opts))
      end
    end
  end
end

RSpec.configure do |config|
  config.include Etcdist::SpecHelper
  config.color = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
