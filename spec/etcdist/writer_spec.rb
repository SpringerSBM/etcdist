require 'spec_helper'

describe Etcdist::Writer do

  let(:etcd) do
    double('etcd').as_null_object
  end

  let(:writer) do
    Etcdist::Writer.new(etcd)
  end

  describe 'PUTs' do

    it 'should put entries in etcd' do
      pretend_etcd_contains(nothing)
      expect(etcd).to receive(:set).with('/foo/bar/fish', value: 'plankton')
      writer.write('/foo/bar' => { 'fish' => 'plankton' })
    end

    it 'should put entries in correct directory' do
      pretend_etcd_contains(nothing)
      expect(etcd).to receive(:set).with('/water/fish', value: 'plankton')
      expect(etcd).to receive(:set).with('/land/cows', value: 'grass')
      writer.write('/water' => { 'fish' => 'plankton' }, '/land' => { 'cows' => 'grass' })
    end

    it 'should not put unchanged entries' do
      pretend_etcd_contains('/foo' => { 'fish' => 'plankton', 'cows' => 'grass' })
      expect(etcd).not_to receive(:set)
      writer.write('/foo' => { 'fish' => 'plankton' })
    end
  end

  describe 'DELETEs' do

    it 'should not delete extra entries by default' do
      pretend_etcd_contains('/foo' => { 'fish' => 'plankton' })
      expect(etcd).not_to receive(:delete)
      writer.write('/foo' => {})
    end

    context 'dangerous mode' do

      let(:writer) do
        Etcdist::Writer.new(etcd, dangerous: true)
      end

      it 'should delete extra entries' do
        pretend_etcd_contains('/foo' => { 'fish' => 'plankton' })
        expect(etcd).to receive(:delete).with('/foo/fish')
        writer.write('/foo' => { 'cows' => 'grass' })
      end

    end

  end

end
