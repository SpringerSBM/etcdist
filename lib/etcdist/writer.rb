require 'etcdist/log'

module Etcdist

  ##
  # Writes data into etcd.
  class Writer

    ##
    # @param [Hash] opts Options
    # @opts [String] :dangerous remove data from etcd (default false)
    def initialize(etcd, opts = {})
      @etcd = etcd
      @dangerous = opts[:dangerous] || false
    end

    def write(data)
      data.each do |dir, entries|
        put(dir, entries)
        delete(dir, entries) if @dangerous
      end
    end

    private
    def put(dir, entries)
      entries.each do |k, v|
        key = [dir, '/', k].join
        @etcd.set(key, value: v)
        Log.debug("wrote #{key}=#{v}")
      end
      Log.info("wrote #{entries.length} entries to #{dir}")
    end

    def delete(dir, entries)
      to_delete = @etcd.get(dir).children.map { |n| n.key } - entries.keys
      to_delete.each do |key|
        @etcd.delete(key)
        Log.debug("deleted #{key}")
      end
      Log.info("deleted #{to_delete.length} entries from #{dir}")
    end

  end
end
