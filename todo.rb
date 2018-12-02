require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:lists] ||= []
end

get "/" do
  redirect "/lists"
end

get "/lists" do
  @lists = session[:lists]
  erb :lists, layout: :layout
end

post "/lists" do
  @new_list = params[:list_name]
  session[:lists] << { name: @new_list, todos: [] }
  redirect "/lists"
end

get "/lists/new" do
  erb :new_list, layout: :layout
end