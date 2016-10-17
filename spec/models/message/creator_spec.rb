require_relative '../../spec_helper'

RSpec.describe Message::Creator do
  let(:params) { {text: 'lorem', days: 3, visits: 5, password: 'ipsum'} }
  subject(:message) { Message::Creator.new(params) }
  let(:store_key) { 'test_key' }

  describe 'validations' do
    it 'will be called before storing an object' do
      expect(message).to receive(:valid?)
      message.store!
    end

    it 'will return error object if will not pass' do
      expect(Message::Creator.new({}).store!).to be_a Message::Error
    end
  end

  describe 'encryption' do
    # it 'will be called before storing an object' do
    #   allow(message).to receive(:valid?).and_return(true)
    #   expect(Message::Encryptor).to receive(:new)
    #   message.store!
    # end
  end

  describe 'redis' do
    it 'will generate a random key before creation' do
      allow(message).to receive(:valid?).and_return(true)
      expect(message).to receive(:store_key)
      message.store!
    end

    it 'the result will be stored' do
      allow(message).to receive(:valid?).and_return(true)
      Redis.current.set('message:test_key', nil)
      allow(message).to receive(:store_key).and_return(store_key)
      message.store!
      expect(Redis.current.get('message:test_key')).to_not eq ''
    end

    it 'the result will be stored in encrypted format' do
      allow(message).to receive(:valid?).and_return(true)
      allow(message).to receive(:store_key).and_return(store_key)
      message.store!
      expect(JSON.parse(Redis.current.get('message:test_key'))['text']).to_not eq message.text
    end
  end
end
