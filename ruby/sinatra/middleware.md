# Middleware

In the Ruby world, Rack is used to manage middleware by organizing all the different middleware applications into a stack and then serving them in order.

Because all the major Ruby frameworks operate with Rack, middleware can be written in Sinatra and then applied, for example, in a Rails application using Rails Metal. In fact, there are a large number of Ruby gems that act as middleware, providing all sorts of functionality such as authentication, caching, and stopping spam prevention.