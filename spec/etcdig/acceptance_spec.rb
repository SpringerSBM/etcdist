# Encoding: utf-8

require 'spec_helper'

describe Etcdig do

  skip 'should do the job' do
    config_dir = File.join(File.dirname(__FILE__), '../data')
    etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
    Etcdig.run(config_dir)
    expect(etcd.get('/etcdig/foo/fish').value).to eq('plankton')
  end

end
