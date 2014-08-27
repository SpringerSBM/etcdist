require 'etcd'
require 'etcdist/log'
require 'etcdist/reader'
require 'etcdist/writer'

##
# This module provides the Etcdist name space
module Etcdist

  Log.level = :info

  ##
  # This is the place to kick things off, i.e. read config data from F/S and
  # write it into it into etcd.
  #
  # @param [String] config_dir The path of the config data root directory
  # @param [Hash] opts The options for new Etcd::Client object
  # @opts [String] :host IP address of the etcd server (default 127.0.0.1)
  # @opts [Fixnum] :port Port number of the etcd server (default 4001)
  def self.execute(config_dir, opts = {})
    etcd = Etcd::Client.new(opts)
    reader = Etcdist::Reader.new
    writer = Etcdist::Writer.new(etcd)

    config = reader.read(config_dir)
    writer.write(config)
  end
end
