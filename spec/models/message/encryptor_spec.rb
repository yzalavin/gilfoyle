require_relative '../../spec_helper'

RSpec.describe Message::Encryptor do
  let(:iv) { "d9'@\xD78q\xBF\xC5-Z\xAC\xC48Zy" }
  let(:params) { { text: 'lorem', hours: 3, visits: 5, password: 'ipsum', encryption_iv: iv} }
  let(:message) { Message::Encryptor.new(params) }

  it 'will respond to encrypt! method' do
    expect(subject).to respond_to :encrypt!
  end

  describe 'encryption' do
    it 'will return message' do
      expect(message.encrypt!).to eq message
    end

    it 'will update origin object with encrypted text' do
      message.encrypt!
      expect(message.text).to_not eq 'lorem'
    end

    it 'will update origin object with encrypted password' do
      message.encrypt!
      expect(message.password).to_not eq 'ipsum'
    end

    it 'will generate different values for objects' do
      message.encrypt!
      expect(message.password).to_not eq message.text
    end

    it 'will not raise error if param is not present', t: true do
      [
        { text: 'lorem', hours: 3, visits: 5, encryption_iv: iv},
        { text: 'lorem', hours: 3, visits: 5, password: '', encryption_iv: iv}
      ].each do |params|
        message = Message::Encryptor.new(params)
        expect(message.encrypt!).to eq message
      end
    end
  end

  describe 'decryption' do
    it 'will update origin text' do
      message.encrypt!
      message.decrypt!
      expect(message.text).to eq 'lorem'
    end

    it 'will update origin password' do
      message.encrypt!
      message.decrypt!
      expect(message.password).to eq 'ipsum'
    end
  end
end
