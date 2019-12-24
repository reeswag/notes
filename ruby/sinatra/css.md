# CSS

.css files should be stored in the public folder and linked to the Erbs as below:

```/public/styles.css```

```
h1 {
    color: #903;
    font: 32px/1 Helvetica, Arial, sans-serif;
}

header h1 {
    font-size: 40px; line-height: 80px;
    background: transparent url(/images/logo.png) 0 0 no-repeat; padding-left: 84px;
}

p {
    font: 13px/1.4 Helvetica, Arial, sans-serif; 
}
```

``` /views/layout.erb```
```
<head>
    <link rel="stylesheet" href="styles.css">
</head>
```
------
## Sass

Getting Sassy CSS preprocessors have become very popular recently as they add a lot of powerful features to the usual CSS hallmarks, such as variables and mixins. The preprocessor variables allow you to assign CSS declarations to variables that can then be reused and finally evaluated in your CSS. For example, you may reuse a color keyword or hexadecimal value assigned to a variable. Amixin reuses fragments ofCSS containing properties or selectors that can be included in other declarations. This helps to keep your CSS DRY, as you only need to write the code once in the mixin.
Two of the most popular CSS preprocessors around at the moment are Sass5 and LESS.6 Sass comes in two flavors: original Sass and the more recent SCSS, which is even closer to CSS. As usual, Sinatra makes it incredibly easy to use either of these. We’re going to focus on using the SCSS flavor of Sass in this book, but if you’re more familiar with one of the others, you should have no problem with those alternatives. To start using Sass, we first have to install the sass gem:

```
$ gem install sass
```

This is a simple route handler that uses the scss to process the styles view when the styles.css file is requested:

-   Create a styles.scss file in the views folder 

-   Create a route handler for it. (I prefer to keep it at the top of the file):

```
 get('/styles.css'){ scss :styles }
 ```
Then add some sass to the .scss file:

### eg

```
$red: #903;
$black: #444;
$white: #fff;
$main-font: Helvetica, Arial, sans-serif;

body {
    font-family: $main-font;
}

h1 {
    color: $red;
    font: 32px/1 $main-font;
}

header h1 {
    font-size: 40px;
    line-height: 80px;
    background: transparent url(/images/logo.png) 00 no-repeat;
    padding-left: 84px;
}

@mixin tabs ($background: blue, $color: yellow) {
    ul {
        list-style: none;
        margin: 0;
        padding: 0;
        background: $background;
        overflow: hidden;
    } 
    
    li { 
        float: left; 
    } 
    a {
        text-decoration: none;
        display: block; 
        padding: 8px;
        background: $background; 
        color: $color; 
        &:hover {
            background: darken($background, 20%);
        } 
    } 
} 

nav {
    @include tabs ($background: $black, $color: $white);
    font-weight: bold;
} 

p { font: 13px/1.4 $main-font;
}
```

In this case the scss file references variables and mixins with overrides to keep the code DRY.

The Tab mixin has two arguments: the background of the tabs and the color we use for the font, which default to blue and yellow respectively. These defaults can be changed when the mixin is used.

The mixin is applied to the nav element, so that any of the elements mentioned in the mixin appearing as children of the nav will have those styles applied to them.