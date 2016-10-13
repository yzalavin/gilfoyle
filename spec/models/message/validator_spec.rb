require_relative '../../spec_helper'

RSpec.describe Message::Validator do
  describe 'will pass' do
    it 'if all restrictions are passed' do
      [
        { message: 'hello', days: 3, password: 'helloworld' },
        { message: 'hello', days: 3 },
        { message: 'hello', visits: 3, password: 'helloworld' },
        { message: 'hello', visits: 2 },
        { message: 'hello', visits: 'fuck', days: 13 }
      ].each do |message|
        p message
        expect(Message::Validator.new(message).provide).to eq true
      end
    end
  end

  # describe 'will not pass' do
  #   it 'if message text is empty' do
  #     expect(subject.new(blank))
  #   end
  #
  #   # it 'if message text is blank' do
  #   #   expect(subject.new(blank)
  #   # end
  #
  #   it 'if days and visits are zero' do
  #   end
  #
  #   it 'if password is less than six characters' do
  #   end
  # end
end
