# ERB

https://medium.com/devlin-delves-in-to-software-development/embedded-ruby-explained-sinatra-battleships-project-part-2-607f53cf4827 


Ruby has a special class ERB, described in Ruby documentation as a ‘templating system’. In basic terms, it is a Ruby class like any other — but it is used to generate as its return value a plain text document, on the basis of an HTML template with Ruby code. Most commonly it is used to generate webpages, but its properties mean it can be used to produce XML documents, RSS feeds and other forms of structured text files. 

### EG

```
template = "<html><h1>Hello, world!</h1></html>"

get "/" do
  ERB.new(template).result
end
```

If we create a new ERB object by ERB.new, we are able to pass it a string. This string will be the basis of the final text document returned, as indicated by my label of ‘template’. This return text is produced by the call to result. 

## Using Variables in ERB
So far, we can pass the ERB object a string, call result on it, and return a string back (to be sent as the response to the browser).
We can pass local variables around within our routes as usual:
```
get "/" do
  word = "hello"
  ERB.new("<h1>#{word}</h1>").result
end
```
Here, the local variable word is interpolated (in the string fed to the ERB object) within the same scope in which it is defined, i.e. all within the scope of the get method. word will therefore be recognised and replaced with its value ‘“hello”’ when the script is executed.

In the following example, word and template also share the same execution context so this can be correctly resolved.

```
word = "hello"
template = "<h1>#{word}</h1>"
get "/" do
  ERB.new(template).result
end
```
In contrast, an error will be returned by the following code:
```
template = "<h1>#{word}</h1>"
get "/" do
  word = "hello"
  ERB.new(template).result
end
```

Why is this? On execution, the call to result on the ERB object will try to resolve the template local variable. There is another local variable called word within that. The template variable does not have access to the higher-level word variable within the get route, so the variable word does not actually have a meaning within template itself and this cannot be resolved.

## Binding

Fortunately, there is a way ‘around’ this.
As per the documentation, “objects of class Binding encapsulate the execution context at some particular place in the code and retain this context for future use.” In other words, the Binding class captures the current scope — the state of the variables, methods and self are all retained.

So, if we add (binding) as a parameter to the call to result in the code snippet above, this essentially captures whatever is within the current scope (i.e. the scope of the get method), which the ERB object can access — and the word variable can access the value “hello” and the code is resolved!

It is rare to see result without the binding argument as it is usually necessary to pass the execution context to the ERB object.

### EG
```
template_2 = "<html><h1><%=@word%></h1></html>"

get "/binding" do
  @word = "It's a Binding World"
  ERB.new(template_2).result(binding)
end
```