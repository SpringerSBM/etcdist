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

    it 'should remove entries' do
      json = JSON.parse('{"node":{"dir":true,"nodes":[{"key":"/foo/fish","value":"plankton"}]}}')
      allow(etcd).to receive(:get).with('/foo').and_return(Etcd::Response.new(json))
      expect(etcd).to receive(:delete).with('/foo/fish')
      writer.write( '/foo' => {} )
    end

  end

end
