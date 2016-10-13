require_relative '../../spec_helper'

RSpec.describe Message::Base do
  let(:params) { { text: 'lorem', days: 3, visits: 5, password: 'ipsum'} }
  let(:message) { Message::Base.new(params) }

  it 'could be initialized without params' do
    expect{ Message::Base.new }.to_not raise_error
  end

  describe 'will allow to get params' do
    it 'text' do
      expect(message.text).to eq 'lorem'
    end

    it 'days' do
      expect(message.days).to eq 3
    end

    it 'visits' do
      expect(message.visits).to eq 5
    end

    it 'password' do
      expect(message.password).to eq 'ipsum'
    end

    it 'will raise error for another value' do
      expect{ message.undefined }.to raise_error NoMethodError
    end

    it 'will return nil if parameter is not specified' do
      expect(Message::Base.new({}).text).to eq nil
    end
  end

  describe 'will allow to write params' do
    it 'that exists' do
      message.text = 'ipsum'
      expect(message.text).to eq 'ipsum'
    end

    it 'an iv param' do
      message.encryption_iv = 'ipsum'
      expect(message.encryption_iv).to eq 'ipsum'
    end
  end

  it 'will not allow to obtain origin initialized hash' do
    expect{ message.params }.to raise_error NoMethodError
  end
end
