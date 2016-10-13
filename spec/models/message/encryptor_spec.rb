require_relative '../../spec_helper'

RSpec.describe Message::Encryptor do
  let(:params) { { text: 'lorem', days: 3, visits: 5, password: 'ipsum'} }
  let(:message) { Message::Encryptor.new(params) }

  it 'will respond to encrypt! method' do
    expect(subject).to respond_to :encrypt!
  end

  describe 'encryption' do
    it 'will update origin obejct with encrypted text' do
      message.encrypt!
      expect(message.text).to_not eq 'lorem'
    end

    it 'will update origin obejct with encrypted password' do
      message.encrypt!
      expect(message.password).to_not eq 'ipsum'
    end
  end

  describe 'decryption' do
    it 'will return origin text and password'
  end
end
