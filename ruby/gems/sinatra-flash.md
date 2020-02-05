# Sinatra::Flash

It is an extension that lets you store information between requests. Often, when an application processes a request, it will redirect to another URL upon finishing, which generates another request. This means that any information from the previous request is lost (due to the stateless nature of HTTP). Sinatra::Flash overcomes this by providing access to the flash—a hash-like object that stores temporary values such as error messages so that they can be retrieved later—usually on the next request. It also removes the information once it’s been used. All this can be achieved via sessions (and that’s exactly how Sinatra::Flash does it), but Sinatra::Flash is easy to implement and provides a number of helper methods.

eg:

```
require 'sinatra/flash'

post '/songs' do
    flash[:notice] = "Song successfully added" if create_song 
    redirect to("/songs/#{@song.id}")
end

```

The above code saves a message to the flash that can then be referenced following a re-direct. 

eg: - add the following to the erb the relevant section:

```
<%=styled_flash%>
```
