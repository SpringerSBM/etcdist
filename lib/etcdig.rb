# Encoding: utf-8

require 'etcd'
##
# This module provides the Etcdig:: name space
module Etcdig
  ##
  # This is the place to kick things off
  def self.run(opts = {})
    client = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
  end
end
