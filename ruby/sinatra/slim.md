# Slim

There are actually a large number of engines that can render HTML in Sinatra using the Tilt interface. At the time of writing, Sinatra supports the following rendering engines:

|                          |                                                     |
|--------------------------|-----------------------------------------------------|
| Haml                     | http://haml.info/                                   |
| ERB                      | http://ruby-doc.org/stdlib/libdoc/erb/rdoc/ERB.html |
| Liquid                   | http://liquidmarkup.org/                            |
| Markdown                 | http://daringfireball.net/projects/markdown/        |
| Textile                  | http://www.textism.com/tools/textile/               |
| Radius                   | http://radius.rubyforge.org/                        |
| Markaby (Markup as Ruby) | http://markaby.rubyforge.org/                       |
| Slim                     | http://slim-lang.com/                               |

## Slim

It reads just like HTML, but without any of the angle brackets and closing tags. Slim uses indentation to avoid closing brackets. Take, for example, the following HTML:

```
<!doctype html>
<html lang="en">
    <head>
        <title><%= @title || "Songs By Sinatra" %></title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <header>
            <h1>Songs By Sinatra</h1>
```
In Slim would be written as:
```
doctype html
html lang="en"
    head
        title= @title || "Songs By Sinatra"
        meta charset="utf-8"
        link rel="stylesheet" href="/styles.css"
    body
        header 
        h1 Songs By Sinatra
```

Notice how it looks a lot tidier and easier to read without all those angle brackets? Ruby can also be embedded in Slim files in much the same way as ERB. A hyphen [-] is used to start blocks of logic that are not to be displayed:
```
- name = '<h1>DAZ</h1>'
```
An equals sign, [=], is used for Ruby that’s to be evaluated and sent to the browser:
```
= name
```

This will be sent back as escaped HTML, so for this snippet the browser would display the full string “<h1>DAZ</h1>”. This can be useful if you want to show the HTML code, or if you lack control over the code that’s being displayed and want to safeguard against any nasty HTML being injected into a page.

If you don’t want the HTML to be escaped, use the double equals ==:
```
== name
```

This would display the string “DAZ” as a level-one heading in the browser. Slim has a number of other handy features that you can find in the online documentation