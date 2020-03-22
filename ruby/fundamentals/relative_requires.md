# Relative Requires

If you want to tidy up your require statements, there are two ways of doing it.

If you’re running Ruby 1.9 or higher, you could use the require_relative method. This requires files relative to where the current file is located, so instead of the require statement we just used, we could simply write:

```
require_relative 'asset-handler'
```

The other option is to add the current directory to Ruby’s load path. The load path is an array of all the places where Ruby should look for files that have been required (the directory where gems are stored is already in the load path, which is why there’s no need to specify where these are when you require them). 

Using the following line of code before your require statements will add the current directory to the load path:

```
$: << '.'
```

Now you can require the files as normal (that is, without the ./):
require 'asset-handler'
If you’re running a version of Ruby lower than 1.9 (though you really shouldn’t
be!), the current directory is already in the load path, so you can just require the
files like this anyway.