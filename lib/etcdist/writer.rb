require 'etcdist/log'

module Etcdist

  ##
  # Writes data into etcd.
  class Writer

    def initialize(etcd)
      @etcd = etcd
    end

    def write(data)
      data.each do |directory, entries|

        entries.each do |k, v|
          directory_and_key = [directory, '/', k].join

          Log.info("writing #{directory_and_key} = #{v}")
          @etcd.set(directory_and_key, value: v)
        end

        keys = @etcd.get(directory).children.map { |n| n.key.sub(/.*\//,'') }
        to_delete = keys - entries.keys

        to_delete.each do |k|
          directory_and_key = [directory, '/', k].join
          Log.info("deleting #{directory_and_key}")
          @etcd.delete(directory_and_key)
        end
      end
    end
    
  end
end
