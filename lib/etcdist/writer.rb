require 'etcdist/log'

module Etcdist

  ##
  # Writes config into etcd.
  class Writer

    def initialize(etcd)
      @etcd = etcd
    end

    def write(config)
      written = 0
      config.each do |directory, entries|
        entries.each do |k, v|
          @etcd.set([directory, '/', k].join, value: v)
          written += 1
        end
      end
      Log.info("wrote #{written} entries to etcd.")
    end
  end
end
