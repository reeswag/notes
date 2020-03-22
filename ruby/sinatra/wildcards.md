# Wildcards

## Route Handlers
Wildcards in route handlers allow us to generalise across a range of different routes.

eg:
```
get '/javascripts/*.js' do # collects any links to JavaScript files.
    pass unless settings.coffeescipt? # pass over this handler and find another matching route if the :coffeescript setting is false.
    coffee (settings.jsdir + '/' + params[:splat].first).to_sym # since we are using a wildcard in the route handler, any route used will be contained in the params[:splat] array.
end
```

Given that we’re using a wildcard in the route handler, any route used will be contained in the ```params[:splat]``` array. Therefore, any number of JavaScript links can be added without us requiring any new route handlers; the middle- ware will pick these routes up and deal with them accordingly.