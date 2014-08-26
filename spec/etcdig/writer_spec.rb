require 'spec_helper'

describe Etcdig::Writer do

  let(:etcd) do
    double('etcd')
  end

  let(:writer) do
    Etcdig::Writer.new(etcd)
  end

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
