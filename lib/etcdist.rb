require 'etcd'
require 'etcdist/log'
require 'etcdist/reader'
require 'etcdist/writer'

# The Etcdist name space
module Etcdist
  Log.level = :info

  # Main entry point to read data from F/S and write into etcd.
  #
  # @param [String] dir The path to the data directory
  # @param [Hash] opts Options
  # @opts [String] :host IP address of the etcd server (default 127.0.0.1)
  # @opts [Fixnum] :port Port number of the etcd server (default 4001)
  def self.execute(dir, opts = {})
    etcd = Etcd::Client.new(opts)
    reader = Etcdist::Reader.new(dir)
    writer = Etcdist::Writer.new(etcd, opts)

    writer.write(reader.read)
    Log.info('Finished successfully.')
  end
end
