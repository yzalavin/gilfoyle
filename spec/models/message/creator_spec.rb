require_relative '../../spec_helper'

RSpec.describe Message::Creator do
  subject(:message) { Message::Creator.new({}) }

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

  describe 'encryption' do
    it 'will delegate encryption to a special object' do
      expect(Message::Encryptor).to receive(:new)
      message.encrypt
    end

    it 'will be called before storing an object' do
      expect(message).to receive(:encrypt)
      message.store!
    end
  end
end
