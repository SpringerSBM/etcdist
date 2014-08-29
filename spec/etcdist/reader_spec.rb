require 'spec_helper'

describe Etcdist::Reader do

  let(:reader) do
    dir = File.join(File.dirname(__FILE__), '../data')
    Etcdist::Reader.new(dir)
  end

  it 'should return directories pointing to key/values' do
    expect(reader.read).to match( { '/etcdist/foo' => { 'fish' => 'plankton', 'cows' => 'grass', 'dogs' => 'bones'} } )
  end

end
