require 'spec_helper'

describe Etcdist::Reader do

  let(:reader) do
    Etcdist::Reader.new
  end

  it 'should return directories pointing to key/values' do
    config_dir = File.join(File.dirname(__FILE__), '../data')
    config = reader.read(config_dir)
    expect(config).to match( { '/etcdist/foo' => { 'fish' => 'plankton', 'cows' => 'grass', 'dogs' => 'bones'} } )
  end

end
