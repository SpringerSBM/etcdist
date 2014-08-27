require 'spec_helper'

describe Etcdist do

  describe "acceptance test - expects etcd running on localhost:4001" do

    let(:etcd_opts) do
      { host: 'localhost', port: 4001 }
    end

    it 'should read config and put entries to etcd' do
      config_dir = File.join(File.dirname(__FILE__), 'data')
      etcd = Etcd.client(etcd_opts)
      Etcdist.execute(config_dir, etcd_opts)
      expect(etcd.get('/etcdist/foo/fish').value).to eq('plankton')
    end

  end

end
