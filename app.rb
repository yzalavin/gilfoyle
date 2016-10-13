require 'sinatra'

get '/' do
  erb :main
end

post '/create_message' do
  p '-----------------'
  p params
  erb :final
end
