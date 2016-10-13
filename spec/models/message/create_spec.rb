require_relative '../../spec_helper'

RSpec.describe Message::Create do
  it 'could be instantiated with a hash of params' do
    expect{ Message::Create.new({}) }.to_not raise_error
  end
end
