require 'etcdist/log'

module Etcdist

  ##
  # Writes data into etcd.
  class Writer

    def initialize(etcd)
      @etcd = etcd
    end

    def write(data)
      written = 0
      data.each do |directory, entries|
        entries.each do |k, v|
          @etcd.set([directory, '/', k].join, value: v)
          written += 1
        end
      end
      Log.info("wrote #{written} entries to etcd.")
    end
  end
end
