# Middleware

In the Ruby world, Rack is used to manage middleware by organizing all the different middleware applications into a stack and then serving them in order.

Because all the major Ruby frameworks operate with Rack, middleware can be written in Sinatra and then applied, for example, in a Rails application using Rails Metal. In fact, there are a large number of Ruby gems that act as middleware, providing all sorts of functionality such as authentication, caching, and stopping spam prevention.

## Example : Asset Handler

Below is some basic code to deal with route handling in a modular application.

```
class AssetHandler < Sinatra::Base
    configure do
        set :views, File.dirname(__FILE__) + '/assets' # this changes the views folder to a new assets folder.
        set :jsdir, 'js'
        set :cssdir, 'css'
        enable :coffeescript
        set :cssengine, 'scss' # this selects the CSS prprocessor
    end

    get '/javascripts/*.js' do # collects any links to JavaScript files.
        pass unless settings.coffeescript? # pass over this handler and find another matching route if the :coffeescript setting is false.
        coffee (settings.jsdir + '/' + params[:splat].first).to_sym # since we are using a wildcard in the route handler, any route used will be contained in the params[:splat] array.
    end

    get '/*.css' do
        send(settings.cssengine, (settings.cssdir + '/' + params[:splat].first).to_sym) # here we use the send method, this lets us invoke a method from the string stored int the :cssengine settng
    end
end
```

To make use of this within the applicaiton:

```
require './asset-handler'

class Website < Sinatra::Base
    use AssetHandler
    ...
end
```


This is a basic example of an asset handler. If you want a more robust and feature-rich option, there are a number to consider such as:
-    Rake::Pipeline https://github.com/livingsocial/rake-pipeline
-   Sinatra AssetPack https://github.com/rstacruz/sinatra-assetpack
-   Sprockets https://github.com/sstephenson/sprockets

## Middleware Settings

The settings in the asset handler middleware could be changed by editing the asset-handler.rb file directly. This isn’t ideal, as we’d prefer to just leave this file as it is, particularly if it’s to be used in other projects. Thankfully, it is possible to change the settings from within the Website class (or anywhere else in our application). This is because settings are actually just methods of the AssetHandler class, so we can simply override those methods to change them. For example, if we didn’t want to use CoffeeScript, we could disable it using the following line: 

```
AssetHandler.disable :coffeescript
```