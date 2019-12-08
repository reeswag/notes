require 'sinatra'
set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

template = "<html><h1>Hello, world!</h1></html>"

get "/" do
  ERB.new(template).result
end

template_2 = "<html><h1><%=@word%></h1></html>"

get "/binding" do
  @word = "It's a Binding World"
  ERB.new(template_2).result(binding)
end
    