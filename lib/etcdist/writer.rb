require 'etcdist/log'

module Etcdist

  ##
  # Writes data into etcd.
  class Writer

    def initialize(etcd)
      @etcd = etcd
    end

    def write(data)
      delete(data)
      set(data)
    end

    private
    def set(data)
      data.each do |directory, entries|
        entries.each do |k, v|
          @etcd.set([directory, '/', k].join, value: v)
        end
        Log.info("wrote #{entries.length} entries to #{directory}")
      end
    end

    def delete(data)
      data.each do |directory, entries|
        keys = @etcd.get(directory).children.map { |n| n.key.sub(/.*\//,'') }
        to_delete = keys - entries.keys
        to_delete.each { |k| @etcd.delete([directory, '/', k].join) }
        Log.info("deleted #{to_delete.length} entries from #{directory}")
      end
    end

  end
end
