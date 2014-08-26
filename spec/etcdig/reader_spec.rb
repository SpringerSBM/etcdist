require 'spec_helper'

describe Etcdig::Reader do

  let(:reader) do
    Etcdig::Reader.new
  end

  it 'should list keyspaces pointing to key/values' do
    config_dir = File.join(File.dirname(__FILE__), '../data')
    config = reader.read(config_dir)
    expect(config).to match( { '/etcdig/foo' => { 'fish' => 'plankton', 'cows' => 'grass' } } )
  end

end
