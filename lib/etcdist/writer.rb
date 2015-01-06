require 'etcdist/log'

module Etcdist
  # Writes data into etcd.
  class Writer
    # @param [Hash] opts Options
    # @opts [String] :dangerous remove data from etcd (default false)
    # @opts [String] :dry_run perform a trial run with no changes made (default false)
    def initialize(etcd, opts = {})
      @etcd = etcd
      @dangerous = opts[:dangerous] || false
      @dry_run = opts[:dry_run] || false
    end

    # Writes data into etcd and optionally removes extra data from etcd
    # @param [Hash] data of type { directory => { key => val } }
    def write(data)
      count = { put: 0, del: 0 }
      data.each do |dir, entries|
        count[:put] += put(dir, entries)
        count[:del] += delete(dir, entries) if @dangerous
      end

      Log.info("#{count[:put]} entries added/modified. #{count[:del]} entries deleted.")
    end

    # Deletes any directories that are present in etcd but not on the file system
    def delete_absent_directories(all_dirs)
      dirs_to_delete = all_etcd_dirs('/').sort.reverse - all_dirs
      dirs_to_delete.each do |dir|
        Log.debug("deleting directory #{dir}") if @dangerous
        @etcd.delete(dir, recursive: true) if @dangerous && !@dry_run
      end

      Log.info("#{dirs_to_delete.length} directories deleted.") if @dangerous
    end

    private

    def put(dir, entries)
      existing = entries_in(dir)
      to_put = entries.select { |k, v| existing[k] != v }
      to_put.each { |k, v| @etcd.set([dir, '/', k].join, value: v) } unless @dry_run
      Log.debug("wrote #{to_put.length} entries to #{dir}: #{to_put}")
      to_put.length
    end

    def delete(dir, entries)
      to_delete = entries_in(dir).keys - entries.keys
      to_delete.each { |k| @etcd.delete([dir, '/', k].join) } unless @dry_run
      Log.debug("deleted #{to_delete.length} entries from #{dir}: #{to_delete}")
      to_delete.length
    end

    def entries_in(dir)
      @etcd.exists?(dir) ? Hash[@etcd.get(dir).children.map { |n| [n.key.sub(/.*\//, ''), n.value] }] : {}
    end

    def all_etcd_dirs(dir)
      root_node = @etcd.get(dir, recursive: true).node

      nodes_to_process_stack = [root_node]
      result = []

      until nodes_to_process_stack.empty?
        node = nodes_to_process_stack.pop
        result.push(node.key)
        node.children.each { |child_node| nodes_to_process_stack.push(child_node) if child_node.dir }
      end

      result
    end
  end
end
