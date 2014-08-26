require 'spec_helper'

describe Etcdist do

  describe "acceptance test" do

    it 'should read config and put entries to etcd' do
      config_dir = File.join(File.dirname(__FILE__), '../data')
      etcd = Etcd.client(host: 'etcd.prod.pe.springer-sbm.com')
      Etcdist.run(config_dir)
      expect(etcd.get('/etcdist/foo/fish').value).to eq('plankton')
    end

  end

end
