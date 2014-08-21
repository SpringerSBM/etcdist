# Encoding: utf-8

require 'etcd'
require 'etcdig/pump'
require 'etcdig/lister'

##
# This module provides the Etcdig:: name space
module Etcdig
  ##
  # This is the place to kick things off
  def self.run(config_dir, opts = {})
    etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')

    @config_dir = File.expand_path(config_dir)

    puts Dir["#{@config_dir}/**/app.properties"].length


    pump = Etcdig::Pump.new(etcd)
  end
end
