require 'etcd'
require 'etcdig/reader'
require 'etcdig/writer'

##
# This module provides the Etcdig:: name space
module Etcdig

  ##
  # This is the place to kick things off, i.e. read config from F/S and write
  # it into etcd.
  def self.run(config_dir, opts = {})
    etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
    reader = Etcdig::Reader.new
    writer = Etcdig::Writer.new(etcd)

    config = reader.read(config_dir)
    writer.write(config)
  end
end
