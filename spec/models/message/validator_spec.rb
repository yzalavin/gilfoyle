require_relative '../../spec_helper'

RSpec.describe Message::Validator do
  describe 'will pass' do
    it 'if all restrictions are passed' do
      [
        { text: 'hello', hours: 3, password: 'helloworld' },
        { text: 'hello', hours: 3 },
        { text: 'hello', visits: 3, password: 'helloworld' },
        { text: 'hello', visits: 3, password: 'ipsumi' },
        { text: 'hello', visits: 2 },
        { text: 'hello', visits: 'fuck', hours: 13 }
      ].each do |message|
        expect(Message::Validator.new(message)).to be_valid
      end
    end
  end

  describe 'will not pass' do
    it 'if message text is not present' do
      message = { hours: 3, password: 'helloworld' }
      expect(Message::Validator.new(message)).to_not be_valid
    end

    it 'if message text is blank' do
      [
        { text: '', hours: 3, password: 'helloworld' },
        { text: '    ', hours: 3, password: 'helloworld' }
      ].each do |message|
        expect(Message::Validator.new(message)).to_not be_valid
      end
    end

    it 'if hours and visits are zero' do
      [
        { text: 'lorem' },
        { text: 'lorem', hours: 0, visits: 0 },
        { text: 'lorem', hours: 'lorem' }
      ].each do |message|
        expect(Message::Validator.new(message)).to_not be_valid
      end
    end

    it 'if password is less than six characters' do
      message = { hours: 3, password: 'ipsum' }
      expect(Message::Validator.new(message)).to_not be_valid
    end
  end
end
