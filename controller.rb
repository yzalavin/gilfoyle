get '/' do
  erb :main
end

post '/message' do
  @message = Message::Creator.new()
  @link = 'fucking_awesome_link'
  erb :final
end

get '/message/:token' do
  # Message::Finder.new()
end

def message_params
  {}.tap { |hash| Message::Base::PARAMS.each { |param| hash[param] = params[param] }}
end
