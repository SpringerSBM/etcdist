# Encoding: utf-8

require 'etcd'
require 'etcdig/pump'

##
# This module provides the Etcdig:: name space
module Etcdig
  ##
  # This is the place to kick things off
  def self.run(opts = {})
    etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
    pump = Etcdig::Pump.new(etcd)
  end
end
