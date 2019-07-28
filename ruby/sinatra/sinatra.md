## <a name='Sinatra'></a>Sinatra

Sinatra is a web framework. The term "framework" generally means "some package that makes it easier for me to do something." In the world of web applications, people create "web frameworks" to compensate for the difficult problems they've encountered when making their own sites. They share these common solutions in the form of a package you can download to bootstrap your own projects.

### <a name='Abasicwebapp'></a>A basic web app

/projects/gothonweb/bin/app.ruby :

```
require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
    greeting = params[:greeting] || "Hi There"
    erb :index, :locals => {'greeting' => greeting}
end
```
Run the application like this:

```
ruby bin/app.rb
```

How it works:

1. Your browser makes a network connection to your own computer, which is called localhost and is a standard way of saying "whatever my own computer is called on the network." It also uses port 8080.
2. Once it connects, it makes an HTTP request to the bin/app.rb application and asks for the / URL, which is commonly the first URL on any website.
3. Inside bin/app.rb you've got a list of URLs and what classes they match. The only one we have is the '/', 'index' mapping. This means that whenever someone goes to / with a browser, Sinatra will find the class index and load it to handle the request.
4. Now that Sinatra has found class index it calls the index.GET method on an instance of that class to actually handle the request. This function runs and simply returns a string for what Sinatra should send to the browser.
5. Finally, Sinatra has handled the request and sends this response to the browser, which is what you are seeing.

### <a name='Rerun'></a>Rerun
When developing using Sinatra, it is important to remember that the entire web app needs to be reloaded whenever changes are made. Doing so can either be done with CTRL-C then running it again, or using the automated rerun gem as follows:

```
rerun 'ruby bin/app.rb'
```

### <a name='InterpretingErrorsinSinatra'></a>Interpreting Errors in Sinatra

1. The top right of the page shows the main error and description
2. The BACKTRACE  section shows a trace of each line involved in the error, just as you'd expect with a ruby error.
3. GET 
4. Post
5. COOKIES

### <a name='PassingparameterstoHTMLviaSinatra'></a>Passing parameters to HTML via Sinatra

This works by defining parameters and assignin them al locals within the relevant html view (as defined in the .erb file)
```
get '/hello/' do
    greeting = params[:greeting] || "Hi There"
    erb :index, :locals => {'greeting' => greeting}
end
```

These locals are then pushed to the html via the following syntax:

```
<%= greeting %>
```
----
###  <a name='BasicWebTheory'></a>Basic Web Theory

![alt text](https://learnrubythehardway.org/book/_static/python/http_flow_graphic.png "Web Diagram")


1. You type in the url http://test.com// into your browser, and it sends the request on line (A) to your computer's network interface.
2. Your request goes out over the internet on line (B) and then to the remote computer on line (C) where my server accepts the request.
3. Once my computer accepts it, my web application gets it on line (D), and my Ruby code runs the index.GET handler.
4. The response comes out of my Ruby server when I return it, and it goes back to your browser over line (D) again.
5. The server running this site takes the response off line (D), then sends it back over the internet on line (C).
6. The response from the server then comes off the internet on line (B), and your computer's network interface hands it to your browser on line (A).
7. Finally, your browser then displays the response.

**Browser**

The software that you're probably using every day. Most people don't know what a browser really does. They just call browsers "the internet." Its job is to take addresses (like http://test.com/) you type into the URL bar, then use that information to make requests to the server at that address.

**Address**

This is normally a URL (Uniform Resource Locator) like http://test.com// and indicates where a browser should go. The first part, http, indicates the protocol you want to use, in this case "Hyper-Text Transport Protocol." You can also try ftp://ibiblio.org/ to see how "File Transport Protocol" works. The http://test.com/ part is the "hostname," a human readable address you can remember and which maps to a number called an IP address, similar to a telephone number for a computer on the internet. Finally, URLs can have a trailing path like the /book/ part of http://test.com//book/, which indicates a file or some resource on the server to retrieve with a request. There are many other parts, but those are the main ones.

**Connection**

Once a browser knows what protocol you want to use (http), what server you want to talk to (http://test.com/), and what resource on that server to get, it must make a connection. The browser simply asks your operating system (OS) to open a "port" to the computer, usually port 80. When it works, the OS hands back to your program something that works like a file, but is actually sending and receiving bytes over the network wires between your computer and the other computer at http://test.com/. This is also the same thing that happens with http://localhost:8080/, but in this case you're telling the browser to connect to your own computer (localhost) and use port 8080 rather than the default of 80. You could also do http://test.com:80/ and get the same result, except you're explicitly saying to use port 80 instead of letting it be that by default.

**Request**

Your browser is connected using the address you gave. Now it needs to ask for the resource it wants (or you want) on the remote server. If you gave /book/ at the end of the URL, then you want the file (resource) at /book/, and most servers will use the real file /book/index.html but pretend it doesn't exist. What the browser does to get this resource is send a request to the server. I won't get into exactly how it does this, but just understand that it has to send something to query the server for the request. The interesting thing is that these "resources" don't have to be files. For instance, when the browser in your application asks for something, the server is returning something your Ruby code generated.

**Server**

The server is the computer at the end of a browser's connection that knows how to answer your browser's requests for files/resources. Most web servers just send files, and that's actually the majority of traffic. But you're actually building a server in Ruby that knows how to take requests for resources and then return strings that you craft using Ruby. When you do this crafting, you are pretending to be a file to the browser, but really it's just code. As you can see from Exercise 50, it also doesn't take much code to create a response.

**Response**

This is the HTML (CSS, JavaScript, or images) your server wants to send back to the browser as the answer to the browser's request. In the case of files, it just reads them off the disk and sends them to the browser, but it wraps the contents of the disk in a special "header" so the browser knows what it's getting. In the case of your application, you're still sending the same thing, including the header, but you generate that data on the fly with your Ruby code.

----

### <a name='FormsandSinatra'></a>Forms and Sinatra

/projects/gothonweb/bin/app.ruby :

```
require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
    erb :hello_form
end

post '/hello/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    erb :index, :locals => {'greeting' => greeting, 'name' => name}
end
```
The views/index.erb file for the post '/hello/' handler to use:
```
<html>
    <head>
        <title>Gothons Of Planet Percal #25</title>
    </head>
<body>

<p>
I just wanted to say <em style="color: green; font-size: 2em;"><%= greeting %>, <%= name %></em>.
</p>

</body>
</html>
```

The web form:

views/hello_form.erb:

```
<html>
    <head>
        <title>Sample Web Form</title>
    </head>
<body>

<h1>Fill Out This Form</h1>

<form action="/hello/" method="POST">
    A Greeting: <input type="text" name="greeting">
    <br/>
    Your Name: <input type="text" name="name">
    <br/>
    <input type="submit">
</form>

</body>
</html>
```
    1. The <form> tag starts it off and says where to deliver this form. In this case it's to action="/hello/" which is our post '/hello/' handler, and method="POST" which tells the browser to use this mechanism.
    2. Text like you might put in another HTML tag, but also...
    3. <input> tags give the type of input fields we want, and the parameters to use. In this case we have two, one with name="greeting" for our params[:greeting] parameters, and name="name" for our params[:name] parameter.
    4. These parameters are then mapped in our post '/hello/' code to create the greeting and name variables which get passed as :locals to the erb :index call.
    5. Finally, the file views/index.erb gets these variables and it prints them.

### <a name='RedactingusingTemplatesinSinatra'></a>Redacting using Templates in Sinatra

As programmers we have to find common patterns and try to automate them away. One common pattern is the HTML that is at the beginning and the end of each of our .erb files. You shouldn't have to type that every single time you want to create a new view, and you should be able to change that content in one place to change all the pages. The solution to this is a concept called a "layout template", which we'll create in views/layout.erb:

```
/layout.erb:

<html>
<head>
    <title>Gothons From Planet Percal #25</title>
</head>
<body>

<%= yield %>

</body>
</html>
```

This simply takes the common HTML at the top and bottom of every template and puts it into one file. The code <%= yield %> is a Ruby thing that says to stop there and run the other view then come back. By putting this into views/layout.erb we're telling Sinatra to "wrap" all of our templates with this HTML.

-----

###  <a name='AutomatingSinatraTests'></a>Automating Sinatra Tests 
You can also automate the testing of your web application using Rack::Test

***E.G***
tests/test_gothonweb.rb:

```
require './bin/app.rb'
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    assert_equal 'Hello world', last_response.body
  end

  def test_hello_form
    get '/hello/'
    assert last_response.ok?
    assert last_response.body.include?('A Greeting')
  end

  def test_hello_form_post
    post '/hello/', params={:name => 'Frank', :greeting => "Hi"}
    assert last_response.ok?
    assert last_response.body.include?('I just wanted to say')
  end
end
```
This file is simply pretending to be a web browser, and it looks similar to how the Sinatra handlers are, but written as if you were telling a browser to visit your webapplication with code. 

The test is run from the project base directory as follows:
```
rake test
```
----

### <a name='IntegratingRubyintoformswithSinatra'></a>Integrating Ruby into forms with Sinatra

WIthin the base app:
```
choices = {
    'HAM' => 'Hamburger',
    'PIZ' => 'Pizza',
    'CUR' => 'Curry',
    'NOO' => 'Noodles',
    }
```
Within the appropriate view:
```
<% choices.each do |id, text| %>
  <li>
    <label class='radio'>
      <input type='radio' name='vote' value='<%= id %>' id='vote_<%= id %>'><%= text %>
    </label>
  </li>
<% end %>
```

#### <a name='TestingRandomnesswithinRuby-UnitTesting'></a>Testing Randomness within Ruby - Unit Testing

https://softwareengineering.stackexchange.com/questions/147134/how-should-i-test-randomness 

https://www.sitepoint.com/rubymine-code-insight-for-ruby-and-rails/ 

##### Kernel#rand and Random
In the past, a random range of numbers might be described like

```
rand(max - min) + min
```
For example, if you wanted to generate a number between 7 and 10, inclusive, you would write:
```
rand(4) + 7
```
Ruby lets you do this in a much more readable manner by passing a Range object to Kernel#rand.
```
>> rand(7..10) 
=> 9
>> rand(1.5..2.8)
=> 1.67699693779624
```

Kernel#srand sets the seed for Kernel#rand. This can be used to generate a reproducible sequence of numbers. This might be handy if you are trying to isolate / reproduce a bug.
```
>> srand(333)
>> 10.times.map { rand(10) }
=> [3, 3, 6, 3, 7, 7, 6, 4, 4, 9]
>> 10.times.map { rand(10) }
=> [7, 5, 5, 8, 8, 7, 3, 3, 3, 9]

>> srand(333)
>> 10.times.map { rand(10) }
=> [3, 3, 6, 3, 7, 7, 6, 4, 4, 9]
>> 10.times.map { rand(10) }
=> [7, 5, 5, 8, 8, 7, 3, 3, 3, 9]
```
If you need multiple generators, then you can access the complete interface to Ruby’s PRNG (Pseudo-Random Number Generator) through Random.
```
>> rng = Random.new
>> rng.rand(10) 
=> 4
```

Random#new can take a seed value as an argument. The #== operator will return true if two Random objects have the same internal state (they started with the same seed and are on the same generation).

```
>> rng1 = Random.new(123)
>> rng2 = Random.new(123)
>> rng1 == rng2
=> true
>> rng1.rand
=> 0.6964691855978616
>> rng1 == rng2
=> false
>> rng2.rand
>> 0.6964691855978616
>> rng1 == rng2
=> true
```
---

