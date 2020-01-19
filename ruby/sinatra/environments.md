# Environments

All Rack applications, including Sinatra, use the concept of environments to signify the stage of development an application is in. There are three predefined environments: development, production (when your app is live on the server), and test.

Development is the default environment in Sinatra. Template files are automatically reloaded on each request, and there are special “not found” and “error” pages that show a stack trace to help with debugging when there’s a problem. You can change the environment when you start the server using the -e flag. For example, if we wanted to start the app using the production environment, we’d launch the server by typing:

```
$ ruby main.rb -e production
```

To check what environment the app is running in, the helper methods production?, development?, and test? will return true or false as appropriate. For example, the following route handler will indicate the environment the app is running in:

```
get '/environment' do 
    if development? 
        "development" 
    elsif production?
        "production" 
    elsif test? 
        "test"
    else "Who knows whaT environment you're in!" 
end
```

## Environmental Configuration

Sinatra makes it possible to set different configuration options depending on the environment. This is done by adding an argument to the configure block that specifies the required environment. For example, you could have a separate configure block for each environment, as shown in this code sample:

```
configure :production do 
    # production configuration here
end

configure :development do 
    #development configuration here
end 

configure :test do 
    #test configuration here 
end