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
      entries.each { |k, v| @etcd.set([dir, '/', k].join, value: v) }
      Log.info("wrote #{entries.length} entries to #{dir}") if Log.level >= :info
      Log.debug("wrote #{entries.length} entries to #{dir}: #{entries}")
    end

    def delete(dir, entries)
      to_delete = @etcd.get(dir).children.map { |n| n.key.sub(/.*\//,'') } - entries.keys
      to_delete.each { |k| @etcd.delete([dir, '/', k].join) }
      Log.info("deleted #{to_delete.length} entries from #{dir}") if Log.level >= :info
      Log.debug("deleted #{to_delete.length} entries from #{dir}: #{to_delete}")
    end

  end
end
