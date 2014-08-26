require 'etcd'
require 'etcdist/reader'
require 'etcdist/writer'

##
# This module provides the Etcdist name space
module Etcdist

  ##
  # This is the place to kick things off, i.e. read config from F/S and write
  # it into etcd.
  def self.run(config_dir, opts = {})
    etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
    reader = Etcdist::Reader.new
    writer = Etcdist::Writer.new(etcd)

    config = reader.read(config_dir)
    writer.write(config)
  end
end
