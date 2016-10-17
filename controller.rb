get '/' do
  erb :main
end

post '/message' do
  @message = Message::Creator.new(message_params).store!
  unless @message.is_a? Message::Error
    @link = "/message/#{@message.store_key}"
    erb :final
  else
    @error = @message.humanize
    erb :main
  end
end

get '/message/:token' do
  @message = Message::Finder.new(params[:token]).find
  if @message
    erb :message
  else
    erb :not_found
  end
end

def message_params
  {}.tap { |hash| Message::Base::PARAMS.each { |param| hash[param] = params[param] }}
end
