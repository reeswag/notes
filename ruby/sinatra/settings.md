# Settings

Settings are application-wide variables that are stored in the settings object, which is accessible throughout the application. There are a number of built-in settings that can be changed, of which some of the more useful ones are presented here:

------
```
:public_folder 
```
This allows you to set the folder that will contain static files. By default, it is called “public,” but it can be changed, for example, to “static”:
```set :public_folder, '/static'```

-----
```
:views
```
This enables you to set which folder contains all the external view files. By default, it is called “views,” but it can be changed, for example, to “templates”:
```set :views, '/templates' ```

-----
```
:static
```
This can be used to set whether Sinatra checks in the public directory for static files before examining route handlers for a matching route. The default option is set to true, but it can be turned off with the following line of code:
```disable :static :root```

This changes the folder that is used as the base of the application. By default, this folder contains the main application file.

-----
```
:app_file
```
 This can be used to set the main application file. It can be useful as it sets the root folder, which, in turn, sets the location of the views and public folders.

 Sinatra will always try to figure out what the app_file is, but there are few situations where you’d want to change this.

-----
 ```
:port
```
This setting is used to establish the port that the application will run on once the web server is started. This is set to 4567 by default, but can be changed like so:```set :port, 1234```

Note that this only works if the server is started by executing the Ruby file, rather than using a rackup file.

-----
```
:show_exceptions
```

This shows a backtrace on error pages to help with debugging. It is enabled by default in development mode, but can be turned off with the following code:
```
configure :development do 
    disable :show_exceptions
end
```

-----
```
:logging
```
 If this is enabled, all error messages are logged to STDERR. By default, it is enabled in classic Sinatra applications (this is the only style we have used so far), but is disabled in modular Sinatra applications.

 -----

 ## Custom Settings

 It’s also possible to create your own custom settings in Sinatra. These can be used for application-wide variables and are stored in the settings object. Custom settings can be easily created using the set method.

 For example, we could create a setting called name with the value of Frank using the following code:
 ```
set :name, "Frank"
```
To access this, we just need to use the settings object like so: settings.name
We can even create dynamic settings using a block: 
```
set(:image_folder){ :root + '/images' }
```

This will append /images at the end of the path to the root folder, and will update if the root folder changes. Here’s another example:
```
set(:dice_roll){ 1 + rand(5) } 
```

This will return a different number every time settings.dice_roll is called.

## Enable and Disable

Settings that can only have Boolean true or false values can also be set using enable and disable for better readability. For example, 
instead of: 
```
set :logging, true
```
we could write:
```
enable :logging
```

These methods also take multiple arguments, so more than one setting can be set to true or false at once, for example: 
```
disable :logging, :sessions
```