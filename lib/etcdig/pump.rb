# Encoding: utf-8

require 'etcd'

module Etcdig
  class Pump

    def initialize(etcd)
      @etcd = etcd
    end

    def execute(key, val)
      @etcd.set(key, value: val)
    end
  end
end
