get '/' do
  erb :main
end

post '/message' do
  @message = Message::Creator.new(Helpers::Message.new.params(params)).store!
  unless @message.is_a? Message::Error
    @link = "/message/#{@message.store_key}"
    @message_duration = Helpers::MessagePresenter.new(@message).duration
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
