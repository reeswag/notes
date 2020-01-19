# Authorisation

## Halt

Sinatra's halt method can stop the application in it's tracks unless a certain criteria is met, eg an admin is logged in.
EG:
```
halt(401,'Not Authorized') unless session[:admin]
```
This issues a 401 status code with the message "Not Authorised".

## Beware Session-Based Authentication

Session-based authentication is certainly not meant to be used in a production setting. If you need a proper authorization system, you should try looking at some of the many gems that are available, such as sinatra-authentication or warden. 

Even then, using sessions for authentication can still leave the application vulnerable to, for example, a CSRF (cross-site request forgery) attack. Sinatra does its best to protect against these attacks, but a better solution would be to avoid using session-based authentication altogether and send a token in the HTTP header.

