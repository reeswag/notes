## HTTP Status Codes

404 is perhaps the most well known of all the HTTP status codes, but there are plenty of others. In fact, the server sends a status code with every response to a request; for example, 200 indicates that everything is okay, 301 means a resource has moved permanently, 404 means the resource is missing, and 500 signifies that there’s been an error.3 By default, Sinatra will send a status code of 200, but you can set it manually using the status method in a route handler; for example:
```
get '/fake-error' do
    status 500 
    "There’s nothing wrong, really :P"
end
```