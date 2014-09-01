require 'etcdist/log'

module Etcdist

  # Writes data into etcd.
  class Writer

    # @param [Hash] opts Options
    # @opts [String] :dangerous remove data from etcd (default false)
    def initialize(etcd, opts = {})
      @etcd = etcd
      @dangerous = opts[:dangerous] || false
    end

    # Writes data into etcd and optionally removes extra data from etcd
    # @param [Hash] data of type { directory => { key => val } }
    def write(data)
      data.each do |dir, entries|
        put(dir, entries)
        delete(dir, entries) if @dangerous
      end
    end

    private
    def put(dir, entries)
      existing = entries_in(dir)
      to_put = entries.select { |k,v| existing[k] != v }
      to_put.each { |k, v| @etcd.set([dir, '/', k].join, value: v) }
      Log.info("wrote #{to_put.length} entries to #{dir}") if Log.level >= :info && to_put.length > 0
      Log.debug("wrote #{to_put.length} entries to #{dir}: #{to_put}")
    end

    def delete(dir, entries)
      to_delete = entries_in(dir).keys - entries.keys
      to_delete.each { |k| @etcd.delete([dir, '/', k].join) }
      Log.info("deleted #{to_delete.length} entries from #{dir}") if Log.level >= :info && to_delete.length > 0
      Log.debug("deleted #{to_delete.length} entries from #{dir}: #{to_delete}")
    end

    def entries_in(dir)
      @etcd.exists?(dir) ? Hash[@etcd.get(dir).children.map { |n| [n.key.sub(/.*\//,''), n.value] }] : {}
    end

  end
end
