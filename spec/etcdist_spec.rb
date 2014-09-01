require 'spec_helper'

describe Etcdist do

  describe 'acceptance test - expects etcd running on localhost:4001' do

    let(:etcd_opts) do
      { host: 'localhost', port: 4001 }
    end

    let(:etcd) do
      Etcd.client(etcd_opts)
    end

    let(:dir) do
      File.join(File.dirname(__FILE__), 'data')
    end

    it 'should read data and put entries to etcd' do
      Etcdist.execute(dir, etcd_opts)
      expect(etcd.get('/etcdist/foo/fish').value).to eq('plankton')
    end

  end

end
