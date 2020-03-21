# Modular Apps

Classic Sinatra Applicatons make use of the top-level DSL of Ruby, meaning that all the methods exist in the top-level scope of the main object. The application itself is represented by the Sinatra::Application object.

It is also possible to build modular applications that use separate classes. Using separate classes means that the global namespace is not polluted, as all the methods will be defined in the scope of a specific class. 

Using the modular style also allows multiple Sinatra applications for each Ruby process.

Modular-style applications are more suited to complex applications and those that are created by multiple developers. It’s fine to use the classic style in most use cases—often it’s the most suitable and immediate way of doing things!

Here’s a basic example of a modular application:

```
require 'sinatra/base'

class ModularApp < Sinatra::Base
    set :name, "Modular App"
    get '/' do
        "Hello from #{settings.name}"
    end

    run! if __FILE__ == $0
end
```
The route handlers (and configuration, helpers, and settings) are all placed inside a class that inherits from Sinatra::Base. It’s important that we require 'sinatra/base' rather than 'sinatra' , as this would trigger creating a classic-style application.

Another difference with modular-style applications is that we have to explicitly start the application using the run! method at the end of the class. The if condition at the end checks to see if the file was directly executed, rather than being used in a test or by a rackup file.

```__FILE__``` is a relative path to the current file in use and $0 represents the name of the file that was executed from the command line. So checking that these two are equal will check if the file that required this one is the file that was executed, rather than, for example, a test file.

## Developing Modular Applicatons

The modular-style application can make it easier to develop large applications, particularly when working in teams. The application can be broken down into smaller modules for each feature and developed in a self-contained environment, possibly by different people. Each module would have its own route handlers and views that are developed independently, before being put together and served up by the main application.

## Registering Extensions

Another big difference between modular applications is that extensions need to be explicitly registered

eg:
```
class Website < Sinatra::Base
    register Sinatra::Auth
    register Sinatra::Flash
```

This gives us more granular control over which extensions are registered with which modules.

## Modular Helpers

Helper blocks are not necessary for modular applications; helper methods are class methods assigned to the app. Since we are using modular apps, all methods are already class methods, no need to worry about helpers!

## Method Overrides

In some cases it is useful to override default behaviour within a Sinatra App. EG the use of the ```_method``` so that we could use PUT and DELETE HTTP methods, even though they lack browser support. 

This is known as method overriding.

The method_override setting is enabled by default in classic applications, but not in modular applications. This means that we’ll have to explicitly enable it in the Song class in order for the update and delete routes to behave as expected and map to the correct route handlers.

```
enable :method_override
```

## Rack Routing

Utilize Rack to route our URLs based on some namespacing. This is done using the config.ru file. When the file is executed using run , we employ Rack to start the applications based on the URL entered (rather than running the application expli- citly).

With Sinatra Applicaitons, the map method is used to create a namespace for the modular classes. This means that any URLs starting with the namespace will be mapped to the route handlers in the specific modular class.

eg:

```
require 'sinatra/base'

require './main'
require './song'

map('/songs') { run SongController }
map('/') { run Website }
```

## Namespace Helper

In order to make sure our routing functions correctly within Sinatra Views we can make use of the URL helper method:

```
a href=url('/whatever')
```

## Subclassing Modules

Once you’ve created some classes in the modular style, you can create subclasses of these. The subclass will inherit all the routes and settings from the parent class, but, as with Ruby methods in subclasses, any routes and settings defined in the subclass will override those in the parent class. Here’s an example to demonstrate:

```
require 'sinatra/base'

class App < Sinatra::Base
    set :name, "App"
    
    get '/' do
        "this is the app"
    end

    get '/hello' do
        "Hello, this is #{settings.name}"
    end
end

class Sub < App
    set :name, "Sub"

    get '/' do
        "This is the sub app"
    end
end

Sub.run!
```

Subclasses are essential to keeping our code DRY. EG using subclasses to share extensions registrations and define helper methods across different modules.

```
class ApplicationController < Sinatra::Base
    register Sinatra::Flash
    register Sinatra::Auth
end

class Website < ApplicationController
    ⋮
end

class Song < ApplicationController
    ⋮
end
```