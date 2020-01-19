# Sessions

HTTP is a stateless protocol, which means that each request is independent of others. In other words, each request knows nothing about the previous or next request. One way to overcome this and keep track of one request to the next is to use sessions. Sinatra uses cookie-based sessions by default, so small amounts of information can be stored in a session cookie on the user’s machine; this information is then accessible via the session hash. Session cookies are destroyed when a user’s session finishes by closing the browser, so the information only persists for this duration. Sessions are also signed while in production mode with a randomly generated token to ensure that no one has been tampering with the cookie. This token can be set manually using the following setting:


set :session_secret, 'try to make this long and hard to guess'