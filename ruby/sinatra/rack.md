# Rack

## Rackupfile
Configuration files used by Rack apps.

In the most basic form they tell rack apps where to look for the main rb file to run.

Eg:
```
require './app' 
run Sinatra::Application
```

the file is stored as config.ru in the root folder for the project.