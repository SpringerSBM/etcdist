require 'etcd'

module Etcdig

  ##
  # Writes config into etcd.
  class Writer

    def initialize(etcd)
      @etcd = etcd
    end

    def write(config)
      config.each do |directory, entries|
        entries.each do |k, v|
          @etcd.set([directory, '/', k].join, value: v)
        end
      end
    end
  end
end
