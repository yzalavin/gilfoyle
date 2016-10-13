require_relative '../../spec_helper'

RSpec.describe Message::Create do
  subject(:message) { Message::Create.new({}) }

  it 'could be instantiated with a hash of params' do
    expect{ subject }.to_not raise_error
  end

  describe 'validations' do
    it 'may be called from outiside object' do
      expect(subject).to respond_to :valid?
    end

    it 'will delagate validations to a special object' do
      expect(Message::Validator).to receive(:new)
      message.valid?
    end

    it 'will be called before storing an object' do
      expect(message).to receive(:valid?)
      message.store!
    end
  end
end