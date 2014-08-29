require 'spec_helper'

describe Etcdist::Writer do

  let(:etcd) do
    double('etcd').as_null_object
  end

  let(:writer) do
    Etcdist::Writer.new(etcd)
  end

  describe 'PUTs' do

    it 'should store entries in etcd' do
      expect(etcd).to receive(:set).with('/foo/bar/fish', value: 'plankton')
      writer.write( '/foo/bar' => { 'fish' => 'plankton' } )
    end

    it 'should store entries in correct directory' do
      expect(etcd).to receive(:set).with('/water/fish', value: 'plankton')
      expect(etcd).to receive(:set).with('/land/cows', value: 'grass')
      writer.write( '/water' => { 'fish' => 'plankton' }, '/land' => { 'cows' => 'grass' } )
    end
  end

  describe 'DELETEs' do

    let(:res) do
      Etcd::Response.new(JSON.parse('{"node":{"dir":true,"nodes":[{"key":"/foo/fish","value":"plankton"}]}}'))
    end

    it 'should not remove entries by default' do
      allow(etcd).to receive(:get).with('/foo').and_return(res)
      expect(etcd).not_to receive(:delete)
      writer.write( '/foo' => {} )
    end

    context 'dangerous mode' do

      let(:writer) do
        Etcdist::Writer.new(etcd, dangerous: true)
      end

      it 'should remove entries' do
        allow(etcd).to receive(:get).with('/foo').and_return(res)
        expect(etcd).to receive(:delete).with('/foo/fish')
        writer.write( '/foo' => {} )
      end

    end

  end

end
