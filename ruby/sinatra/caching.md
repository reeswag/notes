# Caching

We can improve the performance of our asset handler by adding support for caching.

This is done by setting HTTP headers so that the page is only requested if it’s been updated with the last_modified header (a date) and the etag header. An ETag, or entity tag, is a string used to identify the version of a resource such as a web page.

If a resource changes, its etag should change to reflect this.
Sinatra has some useful helper methods for controlling caching, such as expires, cache_control , last_modified , and etag . These can be used to set the HTTP headers so that Sinatra will check whether a page has been modified before requesting it from the server. If no modification has been made, the page will use a cached version and return a HTTP status code of 304 instead of 200.

## Last Modified Headers

In the below example we set the last_modified headers for our sinatra assets according to the last time the directories were modified using the mtime method of the File object. 

```
last_modified File.mtime(settings.root+'/assets/'+settings.jsdir)
```

EG : To add caching for javascript and css assets, we can do the following:

```
get '/javascripts/*.js' do
    pass unless settings.coffeescript?
    last_modified File.mtime(settings.root+'/assets/'+settings.jsdir)
    cache_control :public, :must_revalidate
    coffee (settings.jsdir + '/' + params[:splat].first).to_sym
end

get '/*.css' do
    last_modified File.mtime(settings.root+'/assets/'+settings.cssdir)
    cache_control :public, :must_revalidate
    send(settings.cssengine, (settings.cssdir + '/' + params[:splat].first).to_sym)
end
```

The :public setting means that any intermediary cache (such as an ISP’s proxy server) can also cache the content in addition to the client. If the data is of a sensitive nature, you could use the :private setting, which only allows cached content to be stored on the local client.
The :must_revalidate setting indicates that the client or intermediary cache must confirm that the content is still up to date on every request.

## Application Start Time

A neat trick for setting the last_modified and etag headers globally is to use the application’s start time.

While this may not strictly be the actual time all files were last modified, we can usually assume that if the application has been restar- ted, something has been changed; therefore, it’s worth flushing the cache out and reloading the pages anyway. 

To do this, the following setting needs to be placed inside a configure block: 
```
configure do
    set :start_time, Time.now 
end 
```

Because the code inside a configure block is only run once when an application starts, this setting will effectively provide the start time of the application.

We can then use this for the last_modified header and convert it to a string for the etag header. It can then be used to apply caching to all the pages in our website using this before filter:

```
before do
    last_modified settings.start_time
    etag settings.start_time.to_s
    cache_control :public, :must_revalidate 
end 
```

This is a useful way of reducing the load on the server in an application by avoiding any needless round trips to the server.