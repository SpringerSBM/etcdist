require 'spec_helper'

describe Etcdig::Lister do

  let(:lister) do
    Etcdig::Lister.new
  end

  it 'should list keyspaces pointing to key/values' do
    config_dir = File.join(File.dirname(__FILE__), '../data')
    result = lister.list(config_dir)
    expect(result).to match( { '/etcdig/foo' => { 'fish' => 'plankton', 'cows' => 'grass' } } )
  end

end
