# Helpers

Creating helper methods is easy; they’re just ordinary methods that are placed inside a helpers block like so: 
```
helpers do
    # helper methods go here 
end
```
Any methods defined in this block can be used within route handlers or views too.

Eg:
What if we currently, had one stylesheet link tag that’s hardcoded into our layout file:
``` 
link rel="stylesheet" href="/styles.css"
```

At some point, we may want to add more stylesheets to our application, so we make a helper method that makes this task easier.

```
helpers do
    def css(*stylesheets)
        stylesheets.map do |stylesheet|
            "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel =\"stylesheet\" />"
        end.join   
    end
end 
```
This creates a helper method called css that accepts any number arguments (signified by the * before the stylesheets argument). A stylesheet link tag is then generated for each argument. The arguments are the filenames of the stylesheet (without the .css extension), and can be given as strings or symbols. For example, this code:

```
css :styles, :custom, :widgets 
```
generates the following links:
```
<link href="/styles.css" media="screen projection" rel="stylesheet"/>
<link href="/custom.css" media="screen projection" rel="stylesheet"/>
<link href="/widgets.css" media="screen projection" rel="stylesheet"/>
```

## Helper Modules

Helpers can be collected under modules where appropriate. 

eg

```
module HelperModule
    def helper_1
        #...
    end

    def helper_2
        #...
    end 

    def helper_3
        #...
    end 
end

helpers HelperModule
```

The last line registers the module as a group of helper methods.