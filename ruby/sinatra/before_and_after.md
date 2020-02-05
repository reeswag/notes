# Before and After

Anything inside a before filter block will be run before each request.
```
before do 
    #insert block
end
```

----

You can add a pattern as an argument to filters so that they only happen if the route matches that pattern. For example, the following filter will apply exclusively to any routes that start with /special/:
```
after '/special/*' do
     # do something special
end
```
----
