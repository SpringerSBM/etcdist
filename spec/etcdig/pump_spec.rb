require 'spec_helper'

describe Etcdig::Pump do

  let(:etcd) do
    double('etcd')
  end

  let(:pump) do
    Etcdig::Pump.new(etcd)
  end

  it 'should pump values into correct keyspace' do
    expect(etcd).to receive(:set).with('/foo/fish', value: 'plankton')
    pump.execute('/foo/fish', 'plankton')
  end

end
